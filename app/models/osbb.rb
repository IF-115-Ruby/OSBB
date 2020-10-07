class Osbb < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE = /\A\d{10}\z/.freeze

  validates :name, presence: { message: 'can not be blank' },
                   length: { minimum: 3, maximum: 255 }
  validates :phone,  format: { with: VALID_PHONE,
                               message: 'is invalid, must be 10 digits long' }
  validates :email,  length: { maximum: 255 },
                     format: { with: VALID_EMAIL_REGEX,
                               message: 'format is not valid' }
  has_many :members, class_name: :user, dependent: :nullify
  has_one :lead, class_name: :user, dependent: :nullify
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
