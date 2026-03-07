import sqlite3
import pprint

conn = sqlite3.connect('C:/dev/github/business/Roberts Enterprise/app/roberts_enterprise.db')
cursor = conn.cursor()
cursor.execute("PRAGMA table_info(pickups)")
pprint.pprint(cursor.fetchall())
