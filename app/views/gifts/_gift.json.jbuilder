json.extract! gift, :id, :name, :description, :price, :created_at, :updated_at
json.url gift_url(gift, format: :json)
