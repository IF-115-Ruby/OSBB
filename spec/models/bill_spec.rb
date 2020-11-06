require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end

  describe 'associations' do
    context 'when belong_to' do
      it { is_expected.to belong_to(:billing_contract).optional }
      it { is_expected.to have_one(:next_bill) }
    end
  end

  describe '#next_date' do
    let!(:billing_contract) { create(:billing_contract) }
    let!(:bill) { create(:bill, billing_contract_id: billing_contract.id, date: 2.days.ago.beginning_of_day) }
    let!(:bill2) { create(:bill, billing_contract_id: billing_contract.id, date: 1.day.ago.beginning_of_day) }
    let!(:time_current) { Time.current }

    before do
      allow(Time).to receive(:current).and_return(time_current)
    end

    it 'returns next bill date if bill has next bill' do
      expect(bill.next_bill).to eq(bill2)
      expect(bill.next_date).to eq(bill2.date)
    end

    it 'return Time.current if bill dosent have next bill' do
      expect(bill2.next_date).to eq(time_current)
      expect(bill2.next_bill).to eq(nil)
    end
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
