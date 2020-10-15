require 'factory_bot'

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

FactoryBot.create_list(:bill, 100)

FactoryBot.create_list(:payment, 100)

BillingContract.all.each do |billing_contract| 
    FactoryBot.create(:bill, billing_contract: billing_contract)
    FactoryBot.create(:payment, billing_contract: billing_contract)
end
