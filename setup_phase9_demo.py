import sqlite3
import datetime

def setup_demo():
    conn = sqlite3.connect('app/bridal_beyond.db')
    cursor = conn.cursor()
    
    # 10 weeks from today
    wedding_target = (datetime.datetime.now() + datetime.timedelta(weeks=10)).strftime('%Y-%m-%d %H:%M:%S')
    
    cursor.execute('''
        UPDATE customers 
        SET wedding_date = ?
        WHERE id IN (
            SELECT customer_id FROM orders o 
            JOIN order_items oi ON o.id = oi.order_id 
            JOIN product_variants pv ON oi.product_variant_id = pv.id 
            JOIN products p ON pv.product_id = p.id 
            WHERE p.brand LIKE '%Maggie Sottero%' OR p.name LIKE '%Maggie Sottero%'
        )
    ''', (wedding_target,))
    
    conn.commit()

    cursor.execute('''
        SELECT o.id FROM orders o 
        JOIN order_items oi ON o.id = oi.order_id 
        JOIN product_variants pv ON oi.product_variant_id = pv.id 
        JOIN products p ON pv.product_id = p.id 
        WHERE p.brand LIKE '%Maggie Sottero%' OR p.name LIKE '%Maggie Sottero%'
        LIMIT 1
    ''')
    order = cursor.fetchone()
    if order:
        print(f"TARGET_ORDER_ID={order[0]}")
    else:
        print("NO_MAGGIE_ORDERS_FOUND")
        
    conn.close()

if __name__ == '__main__':
    setup_demo()
