# frozen_string_literal: true

class Company < ApplicationRecord
  WATER_SUPPLY = "water_supply"
  HEATING = "heating"
  RENT_PAYMENT = "rent_payment"
  ACCOMMODATION_PAYMENT = "accommodation_payment"
  GAS = "gas"
  ELECTRICITY = "electricity"
  GARBAGE_REMOVAL = "garbage_removal"
  INTERNET = "internet"
  INTERCOM = "intercom"
  TV = "tv"
  ELEVATOR = "elevator"
  OTHER = "other"

  COMPANY_TYPE = [
    WATER_SUPPLY,
    HEATING,
    RENT_PAYMENT,
    ACCOMMODATION_PAYMENT,
    GAS,
    ELECTRICITY,
    GARBAGE_REMOVAL,
    INTERNET,
    INTERCOM,
    TV,
    ELEVATOR,
    OTHER
  ].freeze

  enum company_types: COMPANY_TYPE

  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true,
                    numericality: true,
                    length: { minimum: 8, maximum: 14 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }
end

# == Schema Information
#
# Table name: companies
#
#  id           :bigint           not null, primary key
#  company_type :string
#  email        :string
#  fax          :integer
#  name         :string
#  phone        :string(14)
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name)
#
