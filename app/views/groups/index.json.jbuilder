json.array!(@groups) do |group|
  json.extract! group, :id, :name, :room, :task
  json.url group_url(group, format: :json)
end
