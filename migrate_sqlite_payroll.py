import sqlite3
import os

DB_PATH = 'app/roberts_enterprise.db'

def run_migration():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    try:
        # Check if status column already exists in time_entries
        cursor.execute("PRAGMA table_info(time_entries)")
        columns = [row[1] for row in cursor.fetchall()]
        
        if 'status' not in columns:
            print("Adding 'status' column to 'time_entries' table...")
            cursor.execute("ALTER TABLE time_entries ADD COLUMN status TEXT DEFAULT 'Unpaid'")
            print("Successfully added 'status' column.")
        else:
            print("'status' column already exists in 'time_entries'.")

        # Create paystubs table
        print("Creating 'paystubs' table if it doesn't exist...")
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS paystubs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                company_id INTEGER,
                user_id INTEGER NOT NULL,
                period_start DATE,
                period_end DATE,
                total_hours REAL DEFAULT 0.0,
                hourly_rate REAL DEFAULT 0.0,
                base_pay REAL DEFAULT 0.0,
                commission_pay REAL DEFAULT 0.0,
                bonus_pay REAL DEFAULT 0.0,
                total_pay REAL DEFAULT 0.0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                created_by INTEGER,
                FOREIGN KEY(company_id) REFERENCES companies(id),
                FOREIGN KEY(user_id) REFERENCES users(id),
                FOREIGN KEY(created_by) REFERENCES users(id)
            )
        ''')
        print("Successfully ensured 'paystubs' table exists.")

        conn.commit()
        print("Migration completed successfully!")

    except Exception as e:
        print(f"An error occurred during migration: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == '__main__':
    run_migration()
