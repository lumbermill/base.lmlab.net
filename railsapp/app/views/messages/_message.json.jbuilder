json.extract! message, :id, :sender_id, :receiver_id, :type, :body, :opened, :created_at, :updated_at
json.url message_url(message, format: :json)
