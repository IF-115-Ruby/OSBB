require 'rails_helper'

RSpec.describe BillsImport, type: :model do
  let!(:correct_csv_file) { { file: fixture_file_upload('files/bills.csv', 'text/csv') } }
  let!(:correct_xls_file) { { file: fixture_file_upload('files/bills.xls', 'text/xls') } }
  let!(:correct_xlsx_file) { { file: fixture_file_upload('files/bills.xlsx', 'text/xlsx') } }
  let!(:incorrect_csv_file) { { file: fixture_file_upload('files/bills-incorrect.csv', 'text/csv') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not-csv', 'text') } }

  describe '#perform' do
    it 'return true when valid values for csv' do
      expect(described_class.new(correct_csv_file).perform).to be_truthy
    end

    it 'return false when invalid values for csv' do
      expect(described_class.new(incorrect_csv_file).perform).to be_falsey
    end

    it 'return true when valid values for xlsx' do
      expect(described_class.new(correct_xlsx_file).perform).to be_truthy
    end

    it 'return true when valid values for xls' do
      expect(described_class.new(correct_xls_file).perform).to be_truthy
    end

    it 'return false when invalid type of file' do
      expect(described_class.new(incorrect_type_of_file).perform).to be_falsey
    end
  end
end
