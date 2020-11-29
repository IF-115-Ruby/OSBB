json.osbbs do
  json.array!(@osbbs) do |osbb|
    json.id osbb.id
    json.name osbb.name
    json.phone osbb.phone
    json.email osbb.email
    json.website osbb.website
    json.url search_osbbs_path(osbb)
  end
end
