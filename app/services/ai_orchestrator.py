import os
import json
from openai import OpenAI
from app.database import get_db

class AIOperationalOrchestrator:
    def __init__(self):
        self.api_key = os.environ.get('OPENAI_API_KEY')
        self.client = OpenAI(api_key=self.api_key) if self.api_key else None

    def _resolve_context_id(self, company_id, entity_type, spoken_identifier):
        if not spoken_identifier: return None
        
        db = get_db()
        cursor = db.cursor()
        
        # very simple resolution to find a matching customer
        if entity_type == 'customer':
            cursor.execute("SELECT id FROM customers WHERE company_id=%s AND (first_name || ' ' || last_name) ILIKE %s LIMIT 1", (company_id, f"%{spoken_identifier}%"))
            row = cursor.fetchone()
            if row: return row['id']
            
        elif entity_type == 'po':
            cursor.execute("SELECT id FROM purchase_orders WHERE vendor_id IN (SELECT id FROM vendors WHERE company_id=%s) AND id::text = %s LIMIT 1", (company_id, str(spoken_identifier).replace('#', '').strip()))
            row = cursor.fetchone()
            if row: return row['id']
            
        return None

    def process_voice_command(self, company_id, current_user_id, current_page_context, transcript):
        """
        Stage 1: Intent Extraction and Entity Resolution.
        Never mutates the DB here directly. Returns structured action plan.
        """
        if not self.client:
            return {"status": "error", "message": "AI Orchestration layer is not configured (Missing OPENAI API key)."}
            
        system_prompt = f"""
        You are a routing agent for a bridal boutique ERP.
        Determine the user's intent from their transcript.
        
        Current Context: {current_page_context}
        
        Possible intents:
        - ADD_INTERNAL_TEAM_NOTE
        - BOOK_APPOINTMENT
        - CAPTURE_MEASUREMENTS
        
        Extract these fields in JSON formatted exactly like:
        {{
            "intent": "ADD_INTERNAL_TEAM_NOTE",
            "target_entity_type": "customer", // or "po", "order"
            "spoken_target_identifier": "Jane Smith", // the name they said
            "parameters": {{
               "body": "The note text to save",
               "measurements": {{"bust": 36, "waist": 28, "hips": 39}} // optional
            }}
        }}
        """

        try:
            response = self.client.chat.completions.create(
                model="gpt-4o",
                response_format={ "type": "json_object" },
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": transcript}
                ],
                temperature=0.0
            )
            
            structured_data = json.loads(response.choices[0].message.content)
            
            # Resolve the spoken entity to an actual database ID if possible
            target_id = None
            if "spoken_target_identifier" in structured_data and structured_data["spoken_target_identifier"]:
                target_id = self._resolve_context_id(
                    company_id, 
                    structured_data.get("target_entity_type"), 
                    structured_data["spoken_target_identifier"]
                )
                
            # If we don't know the exact target_id but we have a page_context ID, let's use the page context
            if target_id is None and 'id' in current_page_context:
                target_id = current_page_context['id']
                structured_data['target_entity_type'] = current_page_context.get('type')
                
            structured_data['resolved_target_id'] = target_id
            
            return {
                "status": "success",
                "action_plan": structured_data
            }
        except Exception as e:
            return {
                "status": "error",
                "message": str(e)
            }

    def execute_action_plan(self, company_id, current_user_id, action_plan):
        """
        Stage 2: Deterministic execution of the action plan.
        """
        intent = action_plan.get('intent')
        target_type = action_plan.get('target_entity_type')
        target_id = action_plan.get('resolved_target_id')
        params = action_plan.get('parameters', {})
        
        db = get_db()
        cursor = db.cursor()
        
        # Log the AI Execution (Audit log)
        cursor.execute('''
            INSERT INTO ai_audit_logs 
            (company_id, actor_id, parsed_intent, extracted_entities_json, target_object_type, target_object_id, execution_outcome)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        ''', (company_id, current_user_id, intent, json.dumps(params), target_type, target_id, 'PENDING'))
        audit_id = cursor.fetchone()['id'] if cursor.description else None
        
        response = {"message": "Action not supported yet.", "status": "failed"}
        
        try:
            if intent == 'ADD_INTERNAL_TEAM_NOTE':
                from app.services.team_communication import CommunicationService
                if not target_id:
                    raise ValueError(f"Could not resolve the target {target_type} to save this note against.")
                    
                msg_id = CommunicationService.post_internal_message(
                    company_id=company_id,
                    author_id=current_user_id,
                    body=params.get('body'),
                    entity_type=target_type,
                    entity_id=target_id,
                    transcript_source="VOICE_AI"
                )
                response = {"status": "success", "message": f"Successfully attached note to {target_type} #{target_id}", "msg_id": msg_id}
                
            elif intent == 'CAPTURE_MEASUREMENTS':
                if not target_id or target_type != 'customer':
                    raise ValueError("Measurements must be attached to a specific customer profile.")
                    
                meas = params.get('measurements', {})
                cursor.execute('''
                    INSERT INTO customer_measurements (customer_id, bust, waist, hips, hollow_to_hem) 
                    VALUES (%s, %s, %s, %s, %s)
                    ON CONFLICT(customer_id) DO UPDATE SET
                    bust = EXCLUDED.bust,
                    waist = EXCLUDED.waist,
                    hips = EXCLUDED.hips,
                    hollow_to_hem = EXCLUDED.hollow_to_hem,
                    updated_at = CURRENT_TIMESTAMP
                ''', (target_id, meas.get('bust', 0), meas.get('waist', 0), meas.get('hips', 0), meas.get('hollow_to_hem', 0)))
                response = {"status": "success", "message": "Measurements updated successfully."}
                
            else:
                response = {"status": "ignored", "message": "Intent recognized but handler not implemented."}
                
            if audit_id:
                cursor.execute("UPDATE ai_audit_logs SET execution_outcome = 'SUCCESS' WHERE id = %s", (audit_id,))
            db.commit()
            
        except Exception as e:
            db.rollback()
            if audit_id:
                cursor.execute("UPDATE ai_audit_logs SET execution_outcome = 'FAILED: ' || %s WHERE id = %s", (str(e), audit_id))
                db.commit()
            response = {"status": "error", "message": str(e)}
            
        return response
