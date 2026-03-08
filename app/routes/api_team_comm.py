from flask import Blueprint, request, jsonify, session
from app.services.team_communication import CommunicationService

bp = Blueprint('api_team_comm', __name__, url_prefix='/api/v1/team_comm')

@bp.route('/<entity_type>/<int:entity_id>/messages', methods=['GET'])
def get_messages(entity_type, entity_id):
    if 'user_id' not in session:
        return jsonify({"error": "Unauthorized"}), 401
        
    try:
        messages = CommunicationService.get_thread_messages(
            session['company_id'], 
            entity_type, 
            entity_id, 
            session['user_id']
        )
        return jsonify({"status": "success", "messages": messages})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 400

@bp.route('/<entity_type>/<int:entity_id>/messages', methods=['POST'])
def post_message(entity_type, entity_id):
    if 'user_id' not in session:
        return jsonify({"error": "Unauthorized"}), 401
        
    data = request.json
    body = data.get('body')
    request_exclusion = data.get('request_exclusion', False)
    exclusion_reason = data.get('exclusion_reason')
    
    if not body:
        return jsonify({"error": "Message body is required."}), 400
        
    try:
        msg_id = CommunicationService.post_internal_message(
            company_id=session['company_id'],
            author_id=session['user_id'],
            body=body,
            entity_type=entity_type,
            entity_id=entity_id,
            request_exclusion=request_exclusion,
            exclusion_reason=exclusion_reason
        )
        return jsonify({"status": "success", "message_id": msg_id})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 400

@bp.route('/alerts/count', methods=['GET'])
def get_alert_count():
    if 'user_id' not in session:
        return jsonify({"count": 0}), 401
    count = CommunicationService.get_unread_alerts_count(session['user_id'])
    return jsonify({"count": count})
