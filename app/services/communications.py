from database import get_db

def send_arrival_notification(company_id, customer_id, product_name):
    """
    Simulates sending an automated SMS to a Bride when their gown or accessory arrives.
    In a production app, this would integrate with the Twilio or SendGrid APIs.
    """
    conn = get_db()
    cursor = conn.cursor()
    
    cursor.execute("SELECT first_name, phone, email FROM customers WHERE id = ?", (customer_id,))
    customer = cursor.fetchone()
    
    if not customer:
        print("Communications: Customer not found. Notification aborted.")
        return False
        
    bride_name = customer['first_name']
    
    # Construct the message payload
    message = f"Exciting news, {bride_name}! Your {product_name} has officially arrived. Please call us to schedule your fitting/pickup."
    subject = f"Arrival Alert: {product_name}"
    
    # Here we would normally execute a Twilio SMS or SendGrid POST.
    # For Phase 18, we mock success and log it to the database to build the audit trail UI.
    
    try:
        cursor.execute('''
            INSERT INTO communication_logs (company_id, customer_id, type, subject, message_body, status)
            VALUES (?, ?, 'SMS', ?, ?, 'Sent')
        ''', (company_id, customer_id, subject, message))
        conn.commit()
        return True
    except Exception as e:
        print(f"Communications: Failed to log notification. Error: {e}")
        return False
