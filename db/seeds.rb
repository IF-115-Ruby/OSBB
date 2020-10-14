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
