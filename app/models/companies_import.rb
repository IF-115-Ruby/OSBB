class CompaniesImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def save
    if items.map(&:valid?).all?
      imported_companies.each(&:save!)
      true
    else
      find_errors(items)
      false
    end
  rescue StandardError => e
    errors.add :base, e.message
    false
  end

  private

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def row_to_hash(row, attributes)
    row.to_hash.select { |k| attributes.include? k }
  end

  def load_imported_companies
    spreadsheet = open_spreadsheet
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[spreadsheet.row(1), spreadsheet.row(i)].transpose]
      company = Company.find_by(id: row["id"]) || Company.new
      company.attributes = row_to_hash row, %w[company_type email fax name phone website]
      company.build_address(row_to_hash(row, %w[city country state street]))
      company.build_account(row_to_hash(row, %w[edrpou iban purpose]))
      company
    end
  end

  def imported_companies
    @imported_companies ||= load_imported_companies
  end

  def find_errors(objects)
    objects.each_with_index do |item, index|
      item.errors.full_messages.map do |msg|
        errors.add :base, "#{I18n.t('.row')} #{index / 3 + 2}: #{msg}"
      end
    end
  end

  def items
    imported_companies.map do |company|
      [company, company.address, company.account]
    end.flatten
  end
end
