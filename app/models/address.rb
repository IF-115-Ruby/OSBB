class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true

  validates :city, :country, :state, :street, presence: true

  def address
    [street, city, state, country].compact.join(', ')
  end
  geocoded_by :address
  after_validation :geocode

  def query
    Geocoder.search(address.to_s).first
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
