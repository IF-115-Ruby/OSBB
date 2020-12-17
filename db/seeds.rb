ADRESSES = [
  { country: "Qatar", state: "Doha", city: "Doha", street: "Jawaan" },
  { country: "Senegal", state: "Dakar", city: "Dakar-plateau", street: "Rue Moussé Diop" },
  { country: "Senegal", state: "Dakar", city: "Dakar", street: "Liberté" },
  { country: "Ukraine", state: "Lviv Oblast", city: "Lviv", street: "Sadova" },
  { country: "Ukraine", state: "Ivano-Frankivsk Oblast", city: "Ivano-Frankivsk", street: "Vovchynetska" },
  { country: "Ukraine", state: "Ivano-Frankivsk Oblast", city: "Ivano-Frankivsk", street: "Tychyny" },
  { country: "United States", state: "MA", city: "Abington", street: "Brockton Avenue" },
  { country: "United States", state: "NY", city: "Buffalo", street: "Church" },
  { country: "United States", state: "NY", city: "Commack", street: "Crooked Hill Road" },
  { country: "United States", state: "CT", city: "Manchester", street: "Buckland Hills Dr" },
  { country: "United States", state: "CT", city: "Lisbon", street: "River Rd" },
  { country: "United States", state: "AL", city: "Calera", street: "Hwy" },
  { country: "Netherlands", state: "Groningen", city: "Zuidhorn", street: "Dotterbloem" },
  { country: "Netherlands", state: "Groningen", city: "Zuidbroek", street: "Westeind" },
  { country: "Netherlands", state: "Gelderland", city: "Arnhem", street: "Prumelaan" }
].freeze

FactoryBot.create_list(:user, 2, :with_avatar, role: :admin)
FactoryBot.create_list(:user, 5, :with_avatar, role: :simple)

FactoryBot.create_list(:osbb, 30)

Osbb.all.each do |osbb|
  address = ADRESSES.sample
  FactoryBot.create(:account, accountable: osbb)
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: osbb)
  FactoryBot.create_list(:user, 1, :with_avatar, role: :lead, osbb_id: osbb.id)
  FactoryBot.create_list(:user, 2, :with_avatar, role: :member, osbb_id: osbb.id)
end

User.all.each do |user|
  address = ADRESSES.sample
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: user)
end

User.lead.all.each do |lead|
  FactoryBot.create_list(:news, 10, osbb: lead.osbb, user: lead)
end

FactoryBot.create_list(:company, 50)
Company.all.each do |company|
  FactoryBot.create(:account, accountable: company)
  address = ADRESSES.sample
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: company)
  FactoryBot.create_list(:billing_contract, 5, company: company, user: nil)
end

billing_contracts = BillingContract.all.shuffle
BillingContract.all.each do |contract|
  FactoryBot.create(:meter_reading,billing_contract: contract)
end

User.where.not(role: 'admin').each do |user|
  billing_contracts.pop(50).each do |billing_contract|
    billing_contract.update(user: user)
  end
end

User.where.not(role: ['simple', 'admin']).each do |user|
  user.update(osbb: Osbb.all.sample, approved: true)
end

DATES = [
  "2020-07-11 T17:30:00",
  "2020-08-07 T12:00:00",
  "2020-09-21 T09:45:30"
]

BillingContract.all.each do |billing_contract|
  DATES.each do |date|
    FactoryBot.create(:bill, date: date, billing_contract: billing_contract)
    FactoryBot.create(:payment, date: date, billing_contract: billing_contract)
  end
end

BillingContract.all.each do |billing_contract|
    FactoryBot.create(:payment, date: Time.now.utc, billing_contract: billing_contract)
end
