json.array!(@specialities) do |speciality|
  json.extract! speciality, :id, :number, :name, :form_number, :form_name, :level
  json.url speciality_url(speciality, format: :json)
end
