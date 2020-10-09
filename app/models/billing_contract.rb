class BillingContract < ApplicationRecord
  validates :contract_num,
            presence: true,
            length: {
              maximum: 50
            }
  validates :is_active,
            inclusion: {
              in: [true, false]
            }
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
#
# Indexes
#
#  index_billing_contracts_on_contract_num  (contract_num)
#
