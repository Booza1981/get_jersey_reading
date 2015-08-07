json.array!(@books) do |book|
  json.extract! book, :id, :link, :isbn
  json.url book_url(book, format: :json)
end
