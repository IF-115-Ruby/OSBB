class CompaniesImport < ApplicationsImport
  AMOUNT_ITEMS_IN_ROW = 3
  START_ROW = 2

  private

  def load_imported_companies
    (2..open_spreadsheet.last_row).map do |i|
      row = Hash[[open_spreadsheet.row(1), open_spreadsheet.row(i)].transpose]
      company = Company.new(row_to_hash(row, %w[company_type email fax name phone website]))
      company.build_address(row_to_hash(row, %w[city country state street]))
      company.build_account(row_to_hash(row, %w[edrpou iban purpose]))
      company
    end
  end

  def validate_data?
    items_to_import.each_with_index do |item, index|
      next if item.valid?

      item.errors.full_messages.map do |msg|
        errors.add :base, "#{I18n.t('.row')} #{index / AMOUNT_ITEMS_IN_ROW + START_ROW}: #{msg}"
      end
    end
    errors.empty?
  end

  def items_to_import
    load_imported_companies.flat_map { |company| [company, company.address, company.account] }
  end
end
