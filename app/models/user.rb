class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :first_name, :last_name, :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
