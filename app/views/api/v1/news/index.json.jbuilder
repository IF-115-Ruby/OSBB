json.news @news do |news_item|
  json.call(news_item, :id, :title, :short_description)
end
