FactoryBot.define do
  factory :billing_contract do
    contract_num { Faker::Number.number(digits: 12) }
    company
    user
  end
end

# == Schema Information
#
# Table name: billing_contracts
#
#  id           :bigint           not null, primary key
#  contract_num :string(50)       not null
#  is_active    :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_billing_contracts_on_company_id                   (company_id)
#  index_billing_contracts_on_contract_num                 (contract_num)
#  index_billing_contracts_on_contract_num_and_company_id  (contract_num,company_id) UNIQUE
#  index_billing_contracts_on_user_id                      (user_id)
#  index_billing_contracts_on_user_id_and_company_id       (user_id,company_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
