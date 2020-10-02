FactoryBot.define do
    factory :company do
      name { Faker::Company.name }
      company_type { Faker::Number.number }
      phone { Faker::PhoneNumber.cell_phone_with_country_code }
      email { Faker::Internet.email }
      website { Faker::Internet.domain_name }
      fax { Faker::Number.leading_zero_number(digits: 10) }
    end
  end
  