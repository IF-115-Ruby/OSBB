class Bill < ApplicationRecord
  belongs_to :billing_contract, optional: true
  has_one :next_bill, ->(bill) { where("date > ?", bill.date).ordered_by_date },
          through: :billing_contract, source: :bills

  validates :amount, presence: true

  scope :ordered_by_date, -> { order("date DESC") }

  def next_date
    return Time.current unless next_bill

    next_bill.date
  end
end

# == Schema Information
#
# Table name: bills
#
#  id                  :bigint           not null, primary key
#  amount              :decimal(, )
#  date                :datetime
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
