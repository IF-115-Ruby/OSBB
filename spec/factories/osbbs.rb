FactoryBot.define do
  factory :osbb do
    name { Faker::Company.name }
    phone { Faker::Number.leading_zero_number(digits: 10) }
    email { Faker::Internet.email }
    website { Faker::Internet.domain_name }
    is_available { true }
  end
end
