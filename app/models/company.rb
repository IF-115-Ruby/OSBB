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

  COMPANY_TYPES = [
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

  enum company_type: COMPANY_TYPES

  has_one :account, dependent: :destroy

  has_one :address, as: :addressable, dependent: :destroy
  has_many :billing_contracts, dependent: :destroy
  has_many :users, through: :billing_contracts

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true,
                    numericality: true,
                    length: { minimum: 8, maximum: 14 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :payment_coefficient, presence: true, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: companies
#
#  id                  :bigint           not null, primary key
#  company_type        :integer
#  email               :string
#  fax                 :integer
#  name                :string
#  payment_coefficient :decimal(, )
#  phone               :string(14)
#  website             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name)
#
