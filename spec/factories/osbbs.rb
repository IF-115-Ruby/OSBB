FactoryBot.define do
  factory :osbb do
    name { Faker::Company.name }
    phone { Faker::Number.leading_zero_number(digits: 10) }
    email { Faker::Internet.email }
    website { Faker::Internet.domain_name }
    is_available { true }
  end
end

# == Schema Information
#
# Table name: osbbs
#
#  id           :bigint           not null, primary key
#  email        :string
#  is_available :boolean
#  name         :string
#  phone        :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_osbbs_on_name  (name)
#
