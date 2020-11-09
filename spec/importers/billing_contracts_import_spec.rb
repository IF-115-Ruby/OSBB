require 'rails_helper'

RSpec.describe BillingContractsImport, type: :importer do
  let!(:company) { create(:company, id: '1') }
  let!(:correct_csv) { { file: fixture_file_upload('files/b-contracts/billing_contracts.csv', 'text/csv') } }
  let!(:correct_xlsx) { { file: fixture_file_upload('files/b-contracts/billing-contracts.xlsx') } }
  let!(:incorrect_csv) { { file: fixture_file_upload('files/b-contracts/billing_contracts-untrue.csv', 'text/csv') } }
  let!(:incorrect_xlsx) { { file: fixture_file_upload('files/b-contracts/billing-contracts-untrue.xlsx') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/empty.txt', 'text') } }

  describe '#perform' do
    context 'when using csv files' do
      it 'return true when valid values' do
        expect(described_class.new(correct_csv).perform).to be_truthy
      end

      it 'return false when invalid values' do
        expect(described_class.new(incorrect_csv).perform).to be_falsey
      end
    end

    context 'when using xlsx files' do
      it 'return true when valid values' do
        expect(described_class.new(correct_xlsx).perform).to be_truthy
      end

      it 'return false when invalid values' do
        expect(described_class.new(incorrect_xlsx).perform).to be_falsey
      end
    end

    it 'return false when invalid type of file' do
      expect(described_class.new(incorrect_type_of_file).perform).to be_falsey
    end
  end
end
