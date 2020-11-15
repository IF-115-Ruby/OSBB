FactoryBot.define do
  factory :bill do
    amount { rand(-200.25...50.30) }
    date { Faker::Time.between(from: 1.month.ago, to: DateTime.now) }
    meter_reading { rand(1..50) }
  end
end

# == Schema Information
#
# Table name: bills
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  date                :datetime
#  meter_reading       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
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
