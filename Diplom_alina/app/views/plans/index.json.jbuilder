json.array!(@plans) do |plan|
  json.extract! plan, :id, :specialization, :training_period, :description
  json.url plan_url(plan, format: :json)
end
