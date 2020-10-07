class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  ADMIN = "admin"
  LEAD = "lead"
  MEMBERS = "members"
  SIMPLE = "simple"

  ROLES = [
    ADMIN,
    LEAD,
    MEMBERS,
    SIMPLE
  ].freeze

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, length: { maximum: 255 }
  validates :mobile, presence: true,
                     numericality: true,
                     length: { minimum: 10, maximum: 14 }
  validates :sex, presence: true, length: { maximum: 10 }
  validates :password, presence: true, length: { minimum: 5, maximum: 25 }

  before_save :downcase_email
  enum role: ROLES

  belongs_to :osbb, optional: true

  def full_name
    "#{first_name} #{last_name}"
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  birthday               :date
#  email                  :string(254)      not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string(50)       not null
#  last_name              :string(50)       not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  mobile                 :string
#  role                   :integer
#  sex                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  osbb_id                :bigint

# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_osbb_id  (osbb_id)

# Foreign Keys
#
#  fk_rails_...  (osbb_id => osbbs.id)
#
