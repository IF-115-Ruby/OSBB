json.array! @news do |item|
  json.id item.id
  json.title item.title
  json.short_description item.short_description
end
