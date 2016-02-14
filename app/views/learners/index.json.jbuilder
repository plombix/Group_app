json.array!(@learners) do |learner|
  json.extract! learner, :id, :name, :group_id, :notes, :role
  json.url learner_url(learner, format: :json)
end
