class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, length: { maximum: 255 }

  before_save :downcase_email

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def downcase_email
    self.email = email.downcase!
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string(254)      not null
#  first_name :string(50)       not null
#  last_name  :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
