json.extract! order, :id, :customer_name, :shipping_address, :phone_no, :line_items, :created_at, :updated_at
json.url order_url(order, format: :json)
