json.extract! audit_log, :id, :activity, :user_id, :ip_address, :created_at, :updated_at
json.url audit_log_url(audit_log, format: :json)
