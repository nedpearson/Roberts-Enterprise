import sqlite3

conn = sqlite3.connect("app/roberts_enterprise.db")
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

m, y = "03", "2026"
locations = [1]
placeholders = ','.join('?' for _ in locations)

query = f'''
    SELECT SUM(total) as pool_rev
    FROM orders 
    WHERE company_id = 1 
    AND location_id IN ({placeholders})
    AND status IN ('Active', 'Fulfilled')
    AND strftime('%m', created_at) = ? AND strftime('%Y', created_at) = ?
'''
params = locations + [m, y]
print("Params:", params)
cursor.execute(query, params)
print("Result with date filter:", cursor.fetchone()['pool_rev'])

query_no_date = f'''
    SELECT SUM(total) as pool_rev, strftime('%m', created_at) as raw_m, strftime('%Y', created_at) as raw_y
    FROM orders 
    WHERE company_id = 1 
    AND location_id IN ({placeholders})
    AND status IN ('Active', 'Fulfilled')
'''
cursor.execute(query_no_date, locations)
row = cursor.fetchone()
print("Result WITHOUT date filter:", row['pool_rev'])
print("Raw month/year extracted from actual DB records:", row['raw_m'], row['raw_y'])
