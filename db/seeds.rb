require 'factory_bot'

DATES = [
  "2020-07-11 T17:30:00",
 "2020-08-07 T12:00:00",
  "2020-09-21 T09:45:30"
]

FactoryBot.create_list(:user, 10)
User.all.each { |user| FactoryBot.create(:address, addressable: user) }

FactoryBot.create_list(:osbb, 100)
Osbb.all.each { |osbb| FactoryBot.create(:address, addressable: osbb) }

FactoryBot.create_list(:company, 50)
Company.all.each do |company| 
  FactoryBot.create(:account, company: company)
  FactoryBot.create(:address, addressable: company)
end

FactoryBot.create_list(:billing_contract, 100)

BillingContract.all.each do |billing_contract| 
  DATES.each do |date|
    _amount = Faker
    FactoryBot.create(:bill, amount: _amount, date: date, billing_contract: billing_contract)
    FactoryBot.create(:payment, amount: _amount, date: date, billing_contract: billing_contract)
  end
end
