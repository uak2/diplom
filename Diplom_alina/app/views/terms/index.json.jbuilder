json.array!(@terms) do |term|
  json.extract! term, :id, :term_start, :end_term
  json.url term_url(term, format: :json)
end
