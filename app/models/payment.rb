class Payment < ApplicationRecord
  belongs_to :billing_contract, optional: true

  scope :ordered_by_date, -> { order("date DESC") }
  scope :created_between, lambda { |start_date, end_date|
    where("payments.date >= ? AND payments.date < ?", start_date, end_date)
  }

  validates :amount, presence: true

  scope :ordered_by_date, -> { order("date DESC") }
  scope :created_between, lambda { |start_date, end_date|
    where("payments.date >= ? AND payments.date < ?", start_date, end_date)
  }
end

# == Schema Information
#
# Table name: payments
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
#  index_payments_on_billing_contract_id  (billing_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (billing_contract_id => billing_contracts.id)
#
