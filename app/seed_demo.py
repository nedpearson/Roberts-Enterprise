import sqlite3
import random
from datetime import datetime, timedelta
import hashlib
import os

DB_PATH = os.path.join(os.path.dirname(__file__), 'bridal_beyond.db')

def seed():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Clear existing data except company 1
    tables = ['payment_ledger', 'pickups', 'order_items', 'orders', 'purchase_order_items', 'purchase_orders', 
              'reservations', 'appointments', 'services', 'product_variants', 'products', 'vendors', 'customers', 'users']
    for t in tables:
        cursor.execute("PRAGMA foreign_keys = OFF;")
        try:
            if t != 'users':
                cursor.execute(f"DELETE FROM {t}")
            else:
                cursor.execute(f"DELETE FROM {t} WHERE email != 'admin@bridal.ai'")
        except sqlite3.OperationalError:
            pass # Table might not exist yet
        cursor.execute("PRAGMA foreign_keys = ON;")
    
    conn.commit()

    COMPANY_ID = 1
    LOCATION_ID = 1

    # Ensure admin user exists
    cursor.execute("SELECT id FROM users WHERE email='admin@bridal.ai'")
    admin = cursor.fetchone()
    if not admin:
        cursor.execute("INSERT INTO users (company_id, location_id, first_name, last_name, email, password_hash, role) VALUES (?, ?, ?, ?, ?, ?, ?)",
                       (COMPANY_ID, LOCATION_ID, 'Admin', 'User', 'admin@bridal.ai', 'foo', 'Admin'))
        admin_id = cursor.lastrowid
    else:
        admin_id = admin[0]

    # Create Consultants
    consultants = []
    for first, last in [('Sarah', 'Jenkins'), ('Emily', 'Chen'), ('Jessica', 'Miller'), ('Amanda', 'Rose')]:
        cursor.execute("INSERT INTO users (company_id, location_id, first_name, last_name, email, password_hash, role) VALUES (?, ?, ?, ?, ?, ?, ?)",
                       (COMPANY_ID, LOCATION_ID, first, last, f"{first.lower()}@bridal.ai", "hash", "Stylist"))
        consultants.append(cursor.lastrowid)

    # Create Vendors
    vendors = []
    for vname, cname in [('Vera Wang', 'Vera'), ('Pronovias', 'Maria'), ('Maggie Sottero', 'Maggie'), ('Allure Bridals', 'Steve')]:
        cursor.execute("INSERT INTO vendors (company_id, name, contact_name, email, active) VALUES (?, ?, ?, ?, 1)",
                       (COMPANY_ID, vname, cname, f"orders@{vname.lower().replace(' ','')}.com"))
        vendors.append((cursor.lastrowid, vname))

    # Create Products & Variants
    product_variants = []
    p_types = ['Dress', 'Accessory', 'Veil', 'Shoes']
    for v_id, v_name in vendors:
        for i in range(5):
            ptype = random.choice(p_types)
            base_cost = random.uniform(200, 1500) if ptype == 'Dress' else random.uniform(20, 200)
            price = base_cost * 2.5
            p_name = f"{v_name} {ptype} {i}"
            cursor.execute("INSERT INTO products (vendor_id, type, brand, name, sku, cost, price, active) VALUES (?, ?, ?, ?, ?, ?, ?, 1)",
                           (v_id, ptype, v_name, p_name, f"SKU-{v_id}-{i}", base_cost, price))
            p_id = cursor.lastrowid
            
            # Variants
            for sz in ['0', '2', '4', '6', '8', '10']:
                cursor.execute("INSERT INTO product_variants (product_id, size, color, sku_variant, on_hand_qty) VALUES (?, ?, ?, ?, ?)",
                               (p_id, sz, 'Ivory', f"SKU-{v_id}-{i}-{sz}-IV", random.randint(0, 3)))
                variant_id = cursor.lastrowid
                product_variants.append({
                    'id': variant_id, 'product_id': p_id, 'price': price, 'cost': base_cost, 'name': p_name
                })

    # Create Services
    services = []
    for sname in ['Bridal Appointment', 'Alterations', 'Accessory Styling', 'Pick-up']:
        cursor.execute("INSERT INTO services (company_id, name, duration_minutes, default_price) VALUES (?, ?, ?, ?)",
                       (COMPANY_ID, sname, 60, 0.0))
        services.append(cursor.lastrowid)

    # Create Customers
    customers = []
    now = datetime.now()
    for i in range(50):
        fname = random.choice(['Emma', 'Olivia', 'Ava', 'Isabella', 'Sophia', 'Mia', 'Charlotte', 'Amelia', 'Harper', 'Evelyn'])
        lname = random.choice(['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'])
        w_date = now + timedelta(days=random.randint(30, 365))
        
        cursor.execute("INSERT INTO customers (company_id, location_id, first_name, last_name, email, phone, wedding_date, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                       (COMPANY_ID, LOCATION_ID, fname, lname, f"{fname.lower()}{i}@example.com", f"555-01{i:02d}", w_date.strftime('%Y-%m-%d %H:%M:%S'), admin_id))
        customers.append(cursor.lastrowid)

    # Create Appointments
    for c_id in customers:
        for _ in range(random.randint(1, 3)):
            appt_date = now + timedelta(days=random.randint(-30, 30))
            is_past = appt_date < now
            appt_status = 'Completed' if is_past else random.choice(['Scheduled', 'Checked_In', 'No_Show', 'Cancelled'])
            service_id = random.choice(services)
            consultant = random.choice(consultants)
            
            # id, location_id, customer_id, service_id, assigned_staff_id, start_at, end_at, status, notes, created_by
            cursor.execute("INSERT INTO appointments (location_id, customer_id, service_id, assigned_staff_id, start_at, end_at, status, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                           (LOCATION_ID, c_id, service_id, consultant, appt_date.strftime('%Y-%m-%d %H:%M:%S'), (appt_date + timedelta(hours=1)).strftime('%Y-%m-%d %H:%M:%S'), appt_status, admin_id))

    # Create Orders & Payments
    for c_id in random.sample(customers, 25): # About 25 customers purchased
        order_date = now - timedelta(days=random.randint(1, 90))
        consultant = random.choice(consultants)
        
        # Pick 1-3 items
        items = random.sample(product_variants, random.randint(1, 3))
        subtotal = sum(i['price'] for i in items)
        tax = subtotal * 0.08
        total = subtotal + tax
        
        # order_id, company_id, location_id, customer_id, status, subtotal, tax, total, created_at
        cursor.execute("INSERT INTO orders (company_id, location_id, customer_id, status, subtotal, tax, total, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                       (COMPANY_ID, LOCATION_ID, c_id, 'Active', subtotal, tax, total, order_date.strftime('%Y-%m-%d %H:%M:%S')))
        order_id = cursor.lastrowid
        
        for item in items:
            cursor.execute("INSERT INTO order_items (order_id, product_variant_id, description, qty, unit_price, line_total) VALUES (?, ?, ?, ?, ?, ?)",
                           (order_id, item['id'], item['name'], 1, item['price'], item['price']))
            
        # Payments
        deposit_amount = total * 0.5
        hash_str = hashlib.sha256(f"{order_id}{deposit_amount}{order_date}".encode()).hexdigest()
        # id, order_id, customer_id, type, amount, method, occurred_at, reference, memo, created_by, immutable_hash
        cursor.execute("INSERT INTO payment_ledger (order_id, customer_id, type, amount, method, reference, memo, occurred_at, created_by, immutable_hash) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                       (order_id, c_id, 'Deposit', deposit_amount, 'Card', 'CREDIT-123', 'Initial Deposit', order_date.strftime('%Y-%m-%d %H:%M:%S'), consultant, hash_str))
                       
        if random.random() > 0.5: # 50% paid in full
            final_date = order_date + timedelta(days=10)
            hash_str2 = hashlib.sha256(f"{order_id}{total-deposit_amount}{final_date}".encode()).hexdigest()
            cursor.execute("INSERT INTO payment_ledger (order_id, customer_id, type, amount, method, reference, memo, occurred_at, created_by, immutable_hash) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                           (order_id, c_id, 'Final', total - deposit_amount, 'Card', 'CREDIT-456', 'Final Payment', final_date.strftime('%Y-%m-%d %H:%M:%S'), consultant, hash_str2))
            
        # Create Pickup if needed
        if random.random() > 0.7:
            p_date = now + timedelta(days=random.randint(-5, 15))
            p_status = 'Completed' if p_date < now else 'Scheduled'
            cursor.execute("INSERT INTO pickups (order_id, customer_id, scheduled_at, status, notes) VALUES (?, ?, ?, ?, ?)",
                           (order_id, c_id, p_date.strftime('%Y-%m-%d %H:%M:%S'), p_status, 'Demo Pickup'))

    # Create Purchase Orders
    for v_id, v_name in vendors:
        po_date = now - timedelta(days=random.randint(5, 45))
        status = random.choice(['Draft', 'Submitted', 'Partially_Received', 'Received'])
        expected = po_date + timedelta(days=60)
        
        # Add 1-5 items
        v_variants = [p for p in product_variants if p['name'].startswith(v_name)]
        if not v_variants: continue
        
        items_to_order = random.sample(v_variants, min(len(v_variants), random.randint(1, 5)))
        total_cost = sum(i['cost'] * 2 for i in items_to_order) # qty 2 each
        
        cursor.execute("INSERT INTO purchase_orders (vendor_id, order_date, expected_delivery, status, total_cost, notes, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)",
                       (v_id, po_date.strftime('%Y-%m-%d %H:%M:%S'), expected.strftime('%Y-%m-%d %H:%M:%S'), status, total_cost, 'Demo PO', admin_id))
        po_id = cursor.lastrowid
        
        for item in items_to_order:
            received = 2 if status == 'Received' else (1 if status == 'Partially_Received' else 0)
            cursor.execute("INSERT INTO purchase_order_items (purchase_order_id, product_variant_id, qty_ordered, qty_received, unit_cost) VALUES (?, ?, ?, ?, ?)",
                           (po_id, item['id'], 2, received, item['cost']))

    conn.commit()
    conn.close()

if __name__ == '__main__':
    seed()
    print("Demo data seeded successfully!")
