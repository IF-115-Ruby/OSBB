class Osbb < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE = /\A\d{10}\z/.freeze

  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :phone, format: { with: VALID_PHONE }
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
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
