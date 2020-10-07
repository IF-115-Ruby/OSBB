require 'company'

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    company_type { Company.company_types }
    phone { Faker::Number.leading_zero_number(digits: 10) }
    email { Faker::Internet.email }
    website { Faker::Internet.domain_name }
    fax { Faker::Number.leading_zero_number(digits: 10) }
  end
end
