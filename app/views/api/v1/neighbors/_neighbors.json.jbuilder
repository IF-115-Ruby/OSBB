json.neighbors @neighbors do |neighbor|
  json.call(neighbor, :id, :full_name, :email, :approved, :role)
  json.avatar_url neighbor.avatar.user_index.url
end
