import sqlite3
import os

DB_PATH = 'app/bridal_beyond.db'

def run_migration():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    try:
        # Check if description column already exists in commissions
        cursor.execute("PRAGMA table_info(commissions)")
        columns = {row[1]: row for row in cursor.fetchall()}
        
        needs_migration = False
        if 'description' not in columns:
            needs_migration = True
        elif columns['order_id'][3] == 1: # 3 is the notnull flag
            needs_migration = True
            
        if needs_migration:
            print("Migrating 'commissions' table to allow NULL order_id and add 'description'...")
            
            # Create new table
            cursor.execute('''
                CREATE TABLE IF NOT EXISTS commissions_new (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id INTEGER NOT NULL,
                    order_id INTEGER,
                    description TEXT,
                    amount REAL NOT NULL,
                    status TEXT DEFAULT 'Pending',
                    earned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY(user_id) REFERENCES users(id),
                    FOREIGN KEY(order_id) REFERENCES orders(id)
                )
            ''')
            
            # Copy data
            if 'description' in columns:
                cursor.execute("INSERT INTO commissions_new (id, user_id, order_id, description, amount, status, earned_at) SELECT id, user_id, order_id, description, amount, status, earned_at FROM commissions")
            else:
                cursor.execute("INSERT INTO commissions_new (id, user_id, order_id, amount, status, earned_at) SELECT id, user_id, order_id, amount, status, earned_at FROM commissions")
                
            # Drop old table
            cursor.execute("DROP TABLE commissions")
            
            # Rename new table
            cursor.execute("ALTER TABLE commissions_new RENAME TO commissions")
            
            print("Successfully migrated 'commissions' table.")
        else:
            print("'commissions' table already migrated.")

        conn.commit()
        print("Migration completed successfully!")

    except Exception as e:
        print(f"An error occurred during migration: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == '__main__':
    run_migration()
