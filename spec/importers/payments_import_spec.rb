require 'rails_helper'

RSpec.describe PaymentsImport, type: :model do
  let!(:correct_csv_file) { { file: fixture_file_upload('files/payments_csv.csv', 'text/csv') } }
  let!(:correct_xls_file) { { file: fixture_file_upload('files/payments_xls.xls', 'text/xls') } }
  let!(:correct_xlsx_file) { { file: fixture_file_upload('files/payments_xlsx.xlsx', 'text/xlsx') } }
  let!(:incorrect_csv_file) { { file: fixture_file_upload('files/payments_incorrect_csv.csv', 'text/csv') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not_csv_file', 'text') } }

  describe '#perform' do
    it 'returns true when valid values for csv' do
      expect(described_class.new(correct_csv_file).perform).to be_truthy
    end

    it 'returns false when invalid values for csv' do
      expect(described_class.new(incorrect_csv_file).perform).to be_falsey
    end

    it 'returns true when valid values for xlsx' do
      expect(described_class.new(correct_xlsx_file).perform).to be_truthy
    end

    it 'returns true when valid values for xls' do
      expect(described_class.new(correct_xls_file).perform).to be_truthy
    end

    it 'returns false when invalid type of file' do
      expect(described_class.new(incorrect_type_of_file).perform).to be_falsey
    end
  end
end
