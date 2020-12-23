class Account < ApplicationRecord
  VALID_EDRPOU = /\A\d{8}\z/.freeze
  VALID_IBAN = /\b[A-Z]{2}[0-9]{2}(?: ?[0-9]{6})(?: ?[0-9]{4}){4}(?: ?[0-9]{3})?\b/.freeze

  belongs_to :accountable, polymorphic: true, optional: true
  validates :edrpou, format: { with: VALID_EDRPOU,
                               message: 'is invalid, must be 8 digits long' }, uniqueness: true
  validates :iban, format: { with: VALID_IBAN,
                             message: 'is invalid' }, uniqueness: true
end

# == Schema Information
#
# Table name: accounts
#
#  id               :bigint           not null, primary key
#  accountable_type :string
#  edrpou           :string
#  iban             :string
#  purpose          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  accountable_id   :bigint
#
# Indexes
#
#  index_accounts_on_accountable_type_and_accountable_id  (accountable_type,accountable_id)
#  index_accounts_on_edrpou                               (edrpou) UNIQUE
#  index_accounts_on_iban                                 (iban) UNIQUE
#
