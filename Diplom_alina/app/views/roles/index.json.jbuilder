json.array!(@roles) do |role|
  json.extract! role, :id, :role_num, :role_title
  json.url role_url(role, format: :json)
end
