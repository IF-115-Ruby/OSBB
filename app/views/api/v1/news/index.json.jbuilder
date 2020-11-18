json.call(@news, :current_page)
json.call(@news, :total_pages)

json.news @news do |news|
  json.call(news, :title, :short_description)
end
