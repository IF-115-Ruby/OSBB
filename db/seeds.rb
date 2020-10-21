ADRESSES = [
  { country: "Qatar", state: "Doha", city: "Doha", street: "Souq" },
  { country: "Qatar", state: "Doha", city: "Doha", street: "Al Mergab" },
  { country: "Senegal", state: "Dakar", city: "Dakar-plateau", street: "Rue Moussé Diop" },
  { country: "Senegal", state: "Dakar", city: "Dakar", street: "Liberté" },
  { country: "Senegal", state: "Saint-Louis", city: "Saint-Louis", street: "Square Saint Louis" },
  { country: "Ukraine", state: "Ivano-Frankivsk Oblast", city: "Ivano-Frankivsk", street: "Vovchynetska" },
  { country: "Ukraine", state: "Ivano-Frankivsk Oblast", city: "Ivano-Frankivsk", street: "Tychyny" },
  { country: "USA", state: "MA", city: "Abington", street: "Brockton Avenue" },
  { country: "USA", state: "NY", city: "Cortlandville", street: "Route" },
  { country: "USA", state: "NY", city: "Commack", street: "Crooked Hill Road" },
  { country: "USA", state: "CT", city: "Manchester", street: "Buckland Hills Dr" },
  { country: "USA", state: "CT", city: "Lisbon", street: "River Rd" },
  { country: "USA", state: "AL", city: "Calera", street: "Hwy" },
  { country: "Netherlands", state: "Groningen", city: "Zuidhorn", street: "Dotterbloem" },
  { country: "Netherlands", state: "Groningen", city: "Zuidbroek", street: "Westeind" },
  { country: "Netherlands", state: "Gelderland", city: "Arnhem", street: "Prumelaan" }
].freeze

FactoryBot.create_list(:user, 10)
Osbb.all.each do |user| 
  address = ADRESSES.sample
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: user) 
end

FactoryBot.create_list(:osbb, 100)
Osbb.all.each do |osbb| 
  address = ADRESSES.sample
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: osbb) 
end

FactoryBot.create_list(:company, 50)
Company.all.each do |company| 
  FactoryBot.create(:account, company: company)
  address = ADRESSES.sample
  FactoryBot.create(:address, country: address[:country], state: address[:state], city: address[:city], street: address[:street], addressable: company)
  FactoryBot.create_list(:billing_contract, 5, company: company, user: nil)
end

billing_contracts = BillingContract.all.shuffle

User.select{ |user| user.role != 'admin' }.each do |user|
  billing_contracts.pop(2).each do |billing_contract|
    billing_contract.update(user: user)
  end
end

DATES = [
  "2020-07-11 T17:30:00",
  "2020-08-07 T12:00:00",
  "2020-09-21 T09:45:30"
]

BillingContract.all.each do |billing_contract| 
  DATES.each do |date|
    _amount = Faker::Number.decimal(l_digits: 2)
    FactoryBot.create(:bill, amount: _amount, date: date, billing_contract: billing_contract)
    FactoryBot.create(:payment, amount: _amount, date: date, billing_contract: billing_contract)
  end
end
