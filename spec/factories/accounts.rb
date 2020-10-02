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
