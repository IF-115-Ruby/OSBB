require 'rails_helper'

RSpec.describe CompaniesImport, type: :model do
  describe '#perform' do
    context 'when file extension .csv' do
      let!(:correct_file_csv) { { file: fixture_file_upload('files/companies.csv', 'text/csv') } }
      let!(:incorrect_file_csv) { { file: fixture_file_upload('files/companies-incorrect.csv', 'text/csv') } }

      it 'return true when valid values for csv' do
        expect(described_class.new(correct_file_csv).perform).to be_truthy
      end

      it 'return false when invalid values for csv' do
        expect(described_class.new(incorrect_file_csv).perform).to be_falsey
      end
    end

    context 'when file extension .xls' do
      let!(:correct_file_xls) { { file: fixture_file_upload('files/companies.xls', 'xls') } }
      let!(:incorrect_file_xls) { { file: fixture_file_upload('files/companies-incorrect.xls', 'xls') } }

      it 'return true when valid values for xls' do
        expect(described_class.new(correct_file_xls).perform).to be_truthy
      end

      it 'return false when invalid values for xls' do
        expect(described_class.new(incorrect_file_xls).perform).to be_falsey
      end
    end

    context 'when file extension .xlsx' do
      let!(:correct_file_xlsx) { { file: fixture_file_upload('files/companies.xlsx', 'xlsx') } }
      let!(:incorrect_file_xlsx) { { file: fixture_file_upload('files/companies-incorrect.xlsx', 'xlsx') } }

      it 'return true when valid values for xlsx' do
        expect(described_class.new(correct_file_xlsx).perform).to be_truthy
      end

      it 'return false when invalid values for xlsx' do
        expect(described_class.new(incorrect_file_xlsx).perform).to be_falsey
      end
    end

    context 'when file extension incorrect' do
      let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not-csv', 'text') } }

      it 'return false when invalid type of file' do
        expect(described_class.new(incorrect_type_of_file).perform).to be_falsey
      end
    end
  end
end
