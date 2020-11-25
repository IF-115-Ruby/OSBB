json.extract! user, :id, :full_name, :birthday, :sex, :mobile, :email, :role
if user.avatar?
  json.show_avatar user.avatar.user_show.url
else
  json.show_avatar '/default_a.png'
end
