json.comments do
  json.partial! 'api/v1/news/comments/comment', collection: @comments, as: :comment
end

json.pagination do
  json.page @comments.current_page
  json.pages @comments.total_pages
end
