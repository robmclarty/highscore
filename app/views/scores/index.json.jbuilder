json.array!(@scores) do |score|
  json.extract! score, :id, :name, :score, :game_id
  json.url score_url(score, format: :json)
end
