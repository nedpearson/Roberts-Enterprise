import sqlite3
import json

def run_test():
    conn = sqlite3.connect("app/roberts_enterprise.db")
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    # Get an order month/year to target
    cursor.execute("SELECT strftime('%m', created_at) as m, strftime('%Y', created_at) as y FROM orders LIMIT 1")
    row = cursor.fetchone()
    if not row:
        print("No orders generated to test against.")
        return
        
    m, y = row['m'], row['y']
    print(f"Targeting Orders from Month: {m}, Year: {y}")

    # Configure User 2 (Sarah Smith) for Location Pool Sales at Baton Rouge (Location 1)
    print("Configuring User 2 (Sarah Smith) to receive a 5% cut of Location 1...")
    cursor.execute("UPDATE users SET commission_type = 'LOCATION', commission_locations = '[\"1\", \"2\"]', commission_rate = 5.0 WHERE id = 2")
    conn.commit()

    # === CORE MATH ENGINE VERIFICATION ===
    print("\nExecuting Pool Distribution Engine...")
    cursor.execute("SELECT * FROM users WHERE active = 1 AND company_id = 1 AND commission_type = 'LOCATION'")
    staff_members = cursor.fetchall()
    total_payout = 0.0

    for person in staff_members:
        raw_locs = person['commission_locations']
        print(f"Checking {person['first_name']} {person['last_name']} -> raw locations: {raw_locs}")
        if not raw_locs or not person['commission_rate']:
            continue
            
        try:
            locations = json.loads(raw_locs)
            if not isinstance(locations, list):
                locations = [locations]
        except Exception as e:
            print("Failed to load JSON:", e)
            continue
            
        rate = float(person['commission_rate']) / 100.0
        
        placeholders = ','.join('?' for _ in locations)
        query = f'''
            SELECT SUM(total) as pool_rev
            FROM orders 
            WHERE company_id = 1 
            AND location_id IN ({placeholders})
            AND status IN ('Active', 'Fulfilled')
            AND strftime('%m', created_at) = ? AND strftime('%Y', created_at) = ?
        '''
        params = [int(loc) for loc in locations] + [m, y]
        cursor.execute(query, params)
        pool_total = cursor.fetchone()['pool_rev']
        
        if pool_total and pool_total > 0:
            cut = round(pool_total * rate, 2)
            desc = f"{m}/{y} Pool Payout - Baton Rouge & Covington"
            
            cursor.execute("INSERT INTO commissions (user_id, description, amount, status) VALUES (?, ?, ?, 'Pending')", (person['id'], desc, cut))
            total_payout += cut
            print(f"SUCCESS: Generated {desc} for {person['first_name']} {person['last_name']} -> Amount: ${cut:,.2f} based off ${pool_total:,.2f} revenue.")

    conn.commit()
    print(f"\nFinal Distribution Total: ${total_payout:,.2f}")

if __name__ == '__main__':
    run_test()
