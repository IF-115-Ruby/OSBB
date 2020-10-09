require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:amount) }
  end

  describe 'associations' do
    context 'when belong_to' do
      it 'billing_contract' do is_expected.to belong_to(:billing_contract).optional end
    end
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
