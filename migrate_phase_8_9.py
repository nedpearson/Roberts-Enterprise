import sqlite3

def migrate():
    print("Starting Phase 8 & 9 schema migration...")
    conn = sqlite3.connect('app/roberts_enterprise.db')
    cursor = conn.cursor()

    # PHASE 8: Transfers & Location Inventory
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS location_inventory (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            location_id INTEGER NOT NULL,
            product_variant_id INTEGER NOT NULL,
            qty_on_hand INTEGER DEFAULT 0,
            FOREIGN KEY(location_id) REFERENCES locations(id),
            FOREIGN KEY(product_variant_id) REFERENCES product_variants(id),
            UNIQUE(location_id, product_variant_id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS transfers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            company_id INTEGER NOT NULL,
            from_location_id INTEGER NOT NULL,
            to_location_id INTEGER NOT NULL,
            status TEXT DEFAULT 'In_Transit', -- In_Transit, Received, Cancelled
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            created_by INTEGER,
            received_at TIMESTAMP,
            received_by INTEGER,
            notes TEXT,
            FOREIGN KEY(company_id) REFERENCES companies(id),
            FOREIGN KEY(from_location_id) REFERENCES locations(id),
            FOREIGN KEY(to_location_id) REFERENCES locations(id),
            FOREIGN KEY(created_by) REFERENCES users(id),
            FOREIGN KEY(received_by) REFERENCES users(id)
        )
    ''')

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS transfer_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            transfer_id INTEGER NOT NULL,
            product_variant_id INTEGER NOT NULL,
            qty INTEGER NOT NULL,
            FOREIGN KEY(transfer_id) REFERENCES transfers(id) ON DELETE CASCADE,
            FOREIGN KEY(product_variant_id) REFERENCES product_variants(id)
        )
    ''')

    # Seed Location Inventory from existing global variants (Assign all to Location 1: Baton Rouge)
    # This ensures backwards compatibility with demo data
    print("Seeding location_inventory with existing product_variants data...")
    cursor.execute("SELECT id, on_hand_qty FROM product_variants WHERE on_hand_qty > 0")
    variants = cursor.fetchall()
    for v in variants:
        try:
            cursor.execute("INSERT INTO location_inventory (location_id, product_variant_id, qty_on_hand) VALUES (1, ?, ?)", (v[0], v[1]))
        except sqlite3.IntegrityError:
            pass # Already seeded

    # PHASE 9: Lead Time Intelligence
    try:
        cursor.execute("ALTER TABLE vendors ADD COLUMN lead_time_weeks INTEGER DEFAULT 16")
        print("Added lead_time_weeks to vendors table.")
    except sqlite3.OperationalError:
        print("Column lead_time_weeks already exists on vendors table.")

    # Assign some random lead times for demo data verification
    cursor.execute("UPDATE vendors SET lead_time_weeks = 24 WHERE name LIKE '%Maggie Sottero%'")
    cursor.execute("UPDATE vendors SET lead_time_weeks = 12 WHERE name LIKE '%Allure%'")

    conn.commit()
    conn.close()
    print("Phase 8 & 9 migration completed.")

if __name__ == '__main__':
    migrate()
