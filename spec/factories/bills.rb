FactoryBot.define do
  factory :bill do
    amount { Faker::Number.decimal(l_digits: 2) }
    date { Faker::Time.between(from: 1.day.ago, to: DateTime.now) }
  end
end

# == Schema Information
#
# Table name: bills
#
#  id                  :bigint           not null, primary key
#  amount              :float
#  date                :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  biling_contract_id  :bigint
#  billing_contract_id :bigint
#
# Indexes
#
#  index_bills_on_billing_contract_id  (billing_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (billing_contract_id => billing_contracts.id)
#
