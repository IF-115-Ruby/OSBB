class Account < ApplicationRecord
  VALID_EDRPOU = /\A\d{8}\z/.freeze
  VALID_IBAN = /\b[A-Z]{2}[0-9]{2}(?: ?[0-9]{6})(?: ?[0-9]{4}){4}(?: ?[0-9]{3})?\b/.freeze

  belongs_to :company, optional: true

  validates :edrpou, format: { with: VALID_EDRPOU,
                               message: 'is invalid, must be 8 digits long' }
  validates :iban, format: { with: VALID_IBAN,
                             message: 'is invalid' }
end

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  edrpou     :string
#  iban       :string
#  purpose    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_accounts_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
