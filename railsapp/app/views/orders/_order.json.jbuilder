json.extract! order, :id, :user_id, :checkout_at, :product_id, :quantity, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
