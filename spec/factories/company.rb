require 'company'

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    company_type { Company::COMPANY_TYPES.sample }
    phone { Faker::Number.leading_zero_number(digits: 10) }
    email { Faker::Internet.email }
    website { Faker::Internet.domain_name }
    fax { Faker::Number.leading_zero_number(digits: 10) }
    payment_coefficient { rand(1..10) }
    account
  end
end
