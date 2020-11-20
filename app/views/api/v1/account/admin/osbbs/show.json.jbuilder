json.osbb do
  json.id @osbb.id
  json.name @osbb.name
  json.phone @osbb.phone
  json.email @osbb.email
  json.website @osbb.website
  json.address do
    json.coordinates do
      if @osbb.address.present?
        json.array! @osbb.address.query.coordinates
      else
        json.array! []
      end
    end
    json.full_address @osbb.address.try(:full_address)
  end
  json.account do
    json.iban @osbb.account.try(:iban)
    json.edrpou @osbb.account.try(:edrpou)
  end
end
