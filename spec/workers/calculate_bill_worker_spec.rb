require 'rails_helper'
RSpec.describe CalculateBillWorker, type: :worker do
  let!(:billing_contract) { create(:billing_contract) }

  it 'add new job' do
    expect do
      described_class.perform_async
    end.to change(described_class.jobs, :size).by(1)
  end

  it 'job create bill' do
    expect { subject.perform }.to change { billing_contract.bills.count }.by(1)
  end

  context 'with last bill equal payment' do
    let!(:bill) do
      create(:bill, billing_contract_id: billing_contract.id, amount: -50, date: '2020-11-09',
                    meter_reading: 50)
    end
    let!(:payment) { create(:payment, billing_contract_id: billing_contract.id, amount: 50, date: '2020-11-10') }
    let!(:meter_reading) { create(:meter_reading, value: 150, billing_contract_id: billing_contract.id) }

    describe 'new bill' do
      before { subject.perform }

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f).to eq(-billing_contract.company.payment_coefficient * 100)
      end
    end
  end

  context 'with last bill no equal payment' do
    let!(:bill) do
      create(:bill, billing_contract_id: billing_contract.id, amount: -120, date: '2020-11-09',
                    meter_reading: 50)
    end
    let!(:payment) { create(:payment, billing_contract_id: billing_contract.id, amount: 50, date: '2020-11-10') }
    let!(:meter_reading) { create(:meter_reading, value: 150, billing_contract_id: billing_contract.id) }

    describe 'new bill' do
      before { subject.perform }

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f).to eq(-billing_contract.company.payment_coefficient * 100 - 70)
      end
    end
  end

  context 'with last bill' do
    let!(:bill) do
      create(:bill, billing_contract_id: billing_contract.id, amount: -75, date: '2020-11-09',
                    meter_reading: 50)
    end

    describe 'with meter reading' do
      let!(:meter_reading) { create(:meter_reading, value: 150, billing_contract_id: billing_contract.id) }

      before { subject.perform }

      it 'write meter reading to bill' do
        expect(billing_contract.bills.last.meter_reading).to eq(meter_reading.value)
      end

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f).to eq(-billing_contract.company.payment_coefficient * 100 - 75)
      end
    end

    describe 'without meter reading' do
      before { subject.perform }

      it 'meter reading be nil' do
        expect(billing_contract.bills.last&.meter_reading).to be_nil
      end

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f)
          .to eq(-billing_contract.company.payment_coefficient * described_class::AVERAGE_METER_READING - 75)
      end
    end
  end

  context 'without last bill' do
    describe 'with meter reading' do
      let!(:meter_reading) { create(:meter_reading, value: 150, billing_contract_id: billing_contract.id) }

      before { subject.perform }

      it 'write meter reading to bill' do
        expect(billing_contract.bills.last.meter_reading).to eq(meter_reading.value)
      end

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f).to eq(-billing_contract.company.payment_coefficient * 150)
      end
    end

    describe 'without meter reading' do
      before { subject.perform }

      it 'meter reading be nil' do
        expect(billing_contract.bills.last&.meter_reading).to be_nil
      end

      it 'check bill amount' do
        expect(billing_contract.bills.last.amount.to_f)
          .to eq(-billing_contract.company.payment_coefficient * described_class::AVERAGE_METER_READING)
      end
    end
  end
end
