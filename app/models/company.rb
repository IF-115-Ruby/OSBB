class Company < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/.freeze
  VALID_PHONE = /\A\d{10}\z/.freeze
  enum COMPANY_TYPE: { water_supply: 0, heating: 1, rent_payment: 2, accommodation_payment: 3,
                           gas: 4, electricity: 5, garbage_removal: 6, internet: 7, intercom: 8,
                           tv: 9, elevator: 10, other: 11 }
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: true, format: { with: VALID_PHONE }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
