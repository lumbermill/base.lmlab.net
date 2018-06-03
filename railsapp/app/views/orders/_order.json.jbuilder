json.extract! order, :id, :user_id, :slip_id, :product_id, :amount, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
