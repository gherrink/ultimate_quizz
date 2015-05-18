json.array!(@questions) do |question|
  json.extract! question, :id, :question, :answer_correct, :answer_wrong_1, :answere_wrong_2, :answere_wrong_3, :rating
  json.url question_url(question, format: :json)
end
