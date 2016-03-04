json.array!(@role_users) do |role_user|
  json.extract! role_user, :id, :role, :user
  json.url role_user_url(role_user, format: :json)
end
