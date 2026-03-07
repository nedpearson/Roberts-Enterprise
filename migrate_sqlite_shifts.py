import sqlite3

def migrate_db():
    print("Starting Phase 7 shifts schema migration...")
    conn = sqlite3.connect('app/roberts_enterprise.db')
    cursor = conn.cursor()

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS shifts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            company_id INTEGER NOT NULL,
            location_id INTEGER NOT NULL,
            user_id INTEGER NOT NULL,
            start_time TIMESTAMP NOT NULL,
            end_time TIMESTAMP NOT NULL,
            notes TEXT,
            FOREIGN KEY(company_id) REFERENCES companies(id),
            FOREIGN KEY(location_id) REFERENCES locations(id),
            FOREIGN KEY(user_id) REFERENCES users(id)
        )
    ''')
    
    conn.commit()
    conn.close()
    print("Migration successful: shifts table created/verified.")

if __name__ == '__main__':
    migrate_db()
