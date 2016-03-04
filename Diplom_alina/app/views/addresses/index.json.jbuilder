json.array!(@addresses) do |address|
  json.extract! address, :id, :student
  json.url address_url(address, format: :json)
end
