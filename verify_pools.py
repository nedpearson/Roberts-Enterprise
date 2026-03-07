import sqlite3

def verify_commissions():
    conn = sqlite3.connect('app/roberts_enterprise.db')
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    cursor.execute("SELECT c.id, u.first_name, u.last_name, c.description, c.amount, c.status FROM commissions c JOIN users u ON c.user_id = u.id WHERE c.description IS NOT NULL")
    rows = cursor.fetchall()
    
    if not rows:
        print("No pool payouts generated yet.")
    else:
        for row in rows:
            print(f"Payout found: {row['first_name']} {row['last_name']} -> {row['description']} for ${row['amount']:.2f} ({row['status']})")

if __name__ == '__main__':
    verify_commissions()
