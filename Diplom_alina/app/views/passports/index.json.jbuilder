json.array!(@passports) do |passport|
  json.extract! passport, :id, :series, :number, :code_subdivision, :date_extradition, :passport_issued
  json.url passport_url(passport, format: :json)
end
