class User < ApplicationRecord
  ADMIN = "admin".freeze
  LEAD = "lead".freeze
  MEMBERS = "members".freeze
  SIMPLE = "simple".freeze

  ROLES = [ADMIN, LEAD, MEMBERS, SIMPLE].freeze
  SEX_TYPES = %w[male female no_sex].freeze

  enum role: ROLES
  enum sex: SEX_TYPES

  belongs_to :osbb, optional: true

  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
  has_many :billing_contracts, dependent: :nullify
  has_many :companies, through: :billing_contracts
  has_many :payments, through: :billing_contracts
  has_many :news, dependent: :nullify

  validates_associated :osbb, :address
  accepts_nested_attributes_for :osbb, :address

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true, length: { maximum: 255 }
  validates :mobile, numericality: true, allow_nil: true, length: { minimum: 10, maximum: 14 }
  validate :avatar_size_validation

  scope :non_admin, -> { where.not(role: :admin) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :recoverable

  mount_uploader :avatar, AvatarUploader
  paginates_per 9

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.grouped_collection_by_role
    {
      'admin' => User.admin.limit(2),
      'lead' => User.lead.limit(3),
      'members' => User.members.limit(4),
      'simple' => User.simple.limit(5)
    }
  end

  def companies_for_output
    companies.map(&:name).join(', ')
  end

  def balance_total
    billing_contracts.map(&:balance_utility_provider).inject(0, &:+)
  end

  def last_payment_date
    payments.ordered_by_date.first&.date
  end

  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 3MB" if avatar.size > 3.megabytes
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
#  mobile                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  sex                    :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  osbb_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_osbb_id               (osbb_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (osbb_id => osbbs.id)
#

# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_osbb_id  (osbb_id)

# Foreign Keys
#
#  fk_rails_...  (osbb_id => osbbs.id)
#
