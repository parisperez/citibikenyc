json.array!(@sales) do |sale|
  json.extract! sale, :email, :guid, :product_id
  json.url sale_url(sale, format: :json)
end
