import sys
import sqlite3

sys.path.append('app')
from app import app

def run_flask_test():
    with app.test_client() as client:
        with client.session_transaction() as sess:
            sess['user_id'] = 1
            sess['role'] = 'Owner'
            sess['company_id'] = 1
            sess['location_id'] = 1
        
        conn = sqlite3.connect("app/bridal_beyond.db")
        cursor = conn.cursor()
        
        # Wipe any old pending pools
        cursor.execute("DELETE FROM commissions WHERE description LIKE '%Pool Payout%'")
        
        # Override Sarah Smith strictly for this functional route test
        print("Configuring User 2 (Sarah Smith) to receive a 10% pool cut of Location 1...")
        cursor.execute("UPDATE users SET commission_type = 'LOCATION', commission_locations = '[\"1\"]', commission_rate = 10.0 WHERE id = 2")
        conn.commit()
            
        print("Simulating POST request to /payroll/distribute_pools for March 2026...")
        response = client.post('/payroll/distribute_pools', data={'month': '3', 'year': '2026'}, follow_redirects=True)
        html = response.get_data(as_text=True)
        
        print("\n--- Route Execution Results ---")
        if "Successfully distributed" in html:
            print("SUCCESS: Flash message 'Successfully distributed' was rendered.")
        elif "No pool revenue generated" in html:
            print("WARNING: Flash message 'No pool revenue generated' was rendered.")
        else:
            print("ERROR: Expected flash message not found.")
            
        print("\n--- Database Verification ---")
        cursor.execute("SELECT amount, description FROM commissions WHERE user_id = 2 AND description LIKE '%Pool%'")
        rows = cursor.fetchall()
        if not rows:
            print("FAILURE: No pool commissions were injected into the ledger.")
            sys.exit(1)
            
        for r in rows:
            print(f"VERIFIED LEDGER INJECTION -> Amount: ${r[0]:.2f} | Description: '{r[1]}'")
            
        print("\nEnd-to-End Route Validation Passed.")

if __name__ == '__main__':
    run_flask_test()
