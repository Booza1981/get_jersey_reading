json.array!(@reading_lists) do |reading_list|
  json.extract! reading_list, :id
  json.url reading_list_url(reading_list, format: :json)
end
