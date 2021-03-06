require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end

  describe 'associations' do
    context 'when belong_to' do
      it { is_expected.to belong_to(:billing_contract).optional }
    end
  end

  describe '.created_between' do
    let!(:payment) { create(:payment, date: 1.day.ago) }

    context 'when payments is in date range ' do
      it 'returns one payment' do
        expect(described_class.created_between(2.days.ago, Time.zone.now).to_a).to eq([payment])
      end
    end

    context 'when no payments in set date range ' do
      it 'returns empty collection' do
        expect(described_class.created_between(1.minute.ago, Time.zone.now)).to be_empty
      end
    end
  end
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
