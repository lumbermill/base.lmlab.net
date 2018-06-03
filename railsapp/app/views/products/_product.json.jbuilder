json.extract! product, :id, :user_id, :code, :maker, :name, :size, :price, :cost, :picture_id, :copy, :memo, :created_at, :updated_at
json.url product_url(product, format: :json)
