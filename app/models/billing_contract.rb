class BillingContract < ApplicationRecord
  has_one :last_bill, -> { ordered_by_date }, class_name: 'Bill', inverse_of: :billing_contract
  has_many :bills, dependent: :destroy
  has_one :last_bill, -> { ordered_by_date }, class_name: 'Bill', inverse_of: :billing_contract
  has_many :payments, dependent: :destroy
  has_many :meter_readings, dependent: :destroy

  belongs_to :company
  belongs_to :user, optional: true

  validates :contract_num, presence: true, length: { maximum: 50 }, uniqueness: { scope: :company_id }
  validates :is_active, inclusion: { in: [true, false] }
  validates :user_id, uniqueness: { scope: :company_id }, allow_nil: true
  validates :company_id, presence: true

  paginates_per 6

  def self.to_csv
    attributes = %w[id company_id contract_num is_active]
    CSV.generate(headers: true) do |csv|
      csv << ['Billing Contracts']
      csv << attributes
      all.find_each do |billing_contracts|
        csv << billing_contracts.attributes.values_at(*attributes)
      end
    end
  end

  def balance_utility_provider(bill = last_bill)
    return 0 unless bill

    payments.created_between(bill.date, bill.next_date).sum(:amount) + bill.amount
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
