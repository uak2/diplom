json.array!(@fibs) do |fib|
  json.extract! fib, :id, :belong_to
  json.url fib_url(fib, format: :json)
end
