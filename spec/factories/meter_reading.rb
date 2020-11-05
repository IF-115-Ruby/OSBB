FactoryBot.define do
  factory :meter_reading do
    value { Faker::Number.number(digits: rand(1...6)) }
    billing_contract
  end
end
