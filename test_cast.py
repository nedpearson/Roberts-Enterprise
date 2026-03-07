import sqlite3

conn = sqlite3.connect("app/bridal_beyond.db")
cursor = conn.cursor()

m = 3
y = 2026

query = """
    SELECT SUM(total) 
    FROM orders 
    WHERE company_id = 1 
    AND location_id = 1 
    AND status IN ('Active', 'Fulfilled')
    AND CAST(strftime('%m', created_at) AS INTEGER) = ? 
    AND CAST(strftime('%Y', created_at) AS INTEGER) = ?
"""

cursor.execute(query, [m, y])
result = cursor.fetchone()[0]

print(f"Result with CAST integer filters: {result}")

# Let's also test string concatenation to prove it was a parameter binding bug
query_concat = f"""
    SELECT SUM(total) 
    FROM orders 
    WHERE company_id = 1 
    AND location_id = 1 
    AND status IN ('Active', 'Fulfilled')
    AND strftime('%m', created_at) = '0{m}' 
    AND strftime('%Y', created_at) = '{y}'
"""
cursor.execute(query_concat)
result_concat = cursor.fetchone()[0]
print(f"Result with raw string literal WHERE clause: {result_concat}")
