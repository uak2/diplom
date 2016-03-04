json.array!(@students) do |student|
  json.extract! student, :id, :ducket_date, :ducket_number
  json.url student_url(student, format: :json)
end
