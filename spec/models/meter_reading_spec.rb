require 'rails_helper'

RSpec.describe MeterReading, type: :model do
  let!(:meter_reading) { create(:meter_reading) }
  let(:value) { meter_reading.value }

  describe 'validations' do
    describe 'value' do
      it { is_expected.to allow_value(value).for(:value) }

      it { is_expected.not_to allow_value("").for(:value) }

      it 'valid' do
        allow(meter_reading).to receive(:previous_meter_reading).and_return(10)
        expect(meter_reading).to allow_value(12).for(:value)
      end

      it 'invalid' do
        allow(meter_reading).to receive(:previous_meter_reading).and_return(10)
        expect(meter_reading).not_to allow_value(9).for(:value)
      end
    end
  end

  describe 'associations' do
    describe 'with belong_to' do
      it { is_expected.to belong_to(:billing_contract).optional }
    end
  end

  describe 'custom validations' do
    it 'return nil' do
      allow(meter_reading).to receive(:billing_contract).and_return(nil)
      expect(meter_reading.send(:previous_meter_reading)).to eq(nil)
    end
  end
end

# == Schema Information
#
# Table name: meter_readings
#
#  id                  :bigint           not null, primary key
#  value               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  billing_contract_id :bigint
#
# Indexes
#
#  index_meter_readings_on_billing_contract_id  (billing_contract_id)
#
# Foreign Keys
#
#  fk_rails_...  (billing_contract_id => billing_contracts.id)
#
