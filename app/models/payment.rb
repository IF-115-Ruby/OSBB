class Payment < ApplicationRecord
  belongs_to :billing_contract, optional: true

  validates :amount, presence: true
end

# == Schema Information
#
# Table name: payments
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
#  index_payments_on_billing_contract_id  (billing_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (billing_contract_id => billing_contracts.id)
#
