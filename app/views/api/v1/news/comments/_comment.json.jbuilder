json.id comment.id
json.body comment.body
json.user_avatar comment.user.handle_avatar
json.user_full_name comment.user.full_name
json.time comment.time_ago

if comment.comments.count.positive?
  json.subcomments comment.comments.reverse do |subcomment|
    json.partial! 'api/v1/news/comments/comment', comment: subcomment
  end
end
