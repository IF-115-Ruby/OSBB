json.extract! user, :id, :full_name, :birthday, :sex, :mobile, :email
json.role user.role&.capitalize
json.show_avatar user.handle_avatar

json.address do
  json.country user.address&.country
  json.state user.address&.state
  json.city user.address&.city
  json.street user.address&.street
end

if user.osbb_id?
  json.osbb do
    json.id user.osbb.id
    json.name user.osbb.name
    json.role user.role.capitalize
  end
else
  json.osbb do
    json.role false
  end
end
