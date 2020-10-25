require 'rails_helper'

RSpec.describe CompaniesImport, type: :model do
  let!(:correct_file) { { file: fixture_file_upload('files/companies.csv', 'text/csv') } }
  let!(:incorrect_file) { { file: fixture_file_upload('files/companies-incorrect.csv', 'text/csv') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not-csv', 'text') } }

  describe '#save' do
    it 'return true when valid values' do
      companies_import = described_class.new(correct_file)

      expect(companies_import.save).to eq(true)
    end

    it 'return false when invalid values' do
      companies_import = described_class.new(incorrect_file)

      expect(companies_import.save).to eq(false)
    end

    it 'return false when invalid type of file' do
      companies_import = described_class.new(incorrect_type_of_file)

      expect(companies_import.save).to eq(false)
    end
  end
end
