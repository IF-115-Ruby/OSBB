FactoryBot.define do
  factory :address do
    country { Faker::Address.country }
    state { Faker::Address.state }
    city { Faker::Address.city }
    street { Faker::Address.street_name }
  end
end

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  city             :string
#  country          :string
#  latitude         :float
#  longitude        :float
#  state            :string
#  street           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint
#
# Indexes
#
#  index_addresses_on_addressable_type_and_addressable_id  (addressable_type,addressable_id)
#
