json.extract! @post, :id, :title, :short_description, :long_description, :is_visible
if @post.image?
  json.show_image @post.image.image_show.url
else
  json.show_image '/No-image.jpg'
end
