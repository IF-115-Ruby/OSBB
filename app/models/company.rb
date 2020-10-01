class Company < ApplicationRecord
  VALID_PHONE = /\A\d{10}\z/.freeze
  WATER_SUPPLY = "water_supply".freeze
  HEATING = "heating".freeze
  RENT_PAYMENT = "rent_payment".freeze
  ACCOMMODATION_PAYMENT = "accommodation_payment".freeze
  GAS = "gas".freeze
  ELECTRICITY = "electricity".freeze
  GARBAGE_REMOVAL = "garbage_removal".freeze
  INTERNET = "internet".freeze
  INTERCOM = "intercom".freeze
  TV = "tv".freeze
  ELEVATOR = "elevator".freeze
  OTHER = "other".freeze
  COMPANY_TYPE = [WATER_SUPPLY, HEATING, RENT_PAYMENT, ACCOMMODATION_PAYMENT, GAS,
                  ELECTRICITY, GARBAGE_REMOVAL, INTERNET, INTERCOM, TV,
                  ELEVATOR, OTHER].freeze
  enum company_types: COMPANY_TYPE
  before_save { email.downcase! }

  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  validates :phone, presence: true
  validates :phone, format: { with: VALID_PHONE }
  validates :email, presence: true
  validates :email, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
