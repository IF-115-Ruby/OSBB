class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true

  validates :city, :country, :state, :street, presence: true
end

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  city             :string
#  country          :string
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
