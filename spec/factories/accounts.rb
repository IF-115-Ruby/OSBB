FactoryBot.define do
  factory :account do
    edrpou { Faker::Bank.account_number(digits: 8) }
    iban { Faker::Bank.iban(country_code: 'UA') }
    purpose { Faker::Movies::HarryPotter.quote }
  end
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
