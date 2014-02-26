json.array!(@scores) do |score|
  json.extract! score, :id, :name, :score, :game_id
  json.url game_score_url(@game, score, format: :json)
end
