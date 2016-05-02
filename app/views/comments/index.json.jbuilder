json.array!(@comments) do |comment|
  json.extract! comment, :id, :author_name, :body
  json.url comment_url(comment, format: :json)
end
