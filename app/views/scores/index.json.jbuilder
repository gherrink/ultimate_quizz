json.array!(@scores) do |score|
  json.extract! score, :score, :user, :category
  json.url score_url(score, format: :json)
end
