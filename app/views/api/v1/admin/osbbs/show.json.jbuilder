json.osbb do
  json.id @osbb.id
  json.name @osbb.name
  json.phone @osbb.phone
  json.email @osbb.email
  json.website @osbb.website
  json.address do
    if @osbb.address.present?
      json.coordinates do
        json.latitude @osbb.address.latitude
        json.longitude @osbb.address.longitude
      end
    end
    json.full_address @osbb.address.try(:full_address)
  end
  json.account do
    json.iban @osbb.account.try(:iban)
    json.edrpou @osbb.account.try(:edrpou)
  end
end
