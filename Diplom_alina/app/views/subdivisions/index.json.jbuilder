json.array!(@subdivisions) do |subdivision|
  json.extract! subdivision, :id, :type_num, :type_title
  json.url subdivision_url(subdivision, format: :json)
end
