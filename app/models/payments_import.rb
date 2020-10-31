class PaymentsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes = {})
    attributes.nil? ? raise("File not selected!") : attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def row_to_hash(row, attributes)
    row.to_hash.select { |k| attributes.include? k }.with_indifferent_access
  end

  def load_imported_payments
    spreadsheet = open_spreadsheet
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[spreadsheet.row(1), spreadsheet.row(i)].transpose]
      payment = Payment.find_by(id: row["id"]) || Payment.new
      payment.attributes = row_to_hash row, %w[amount date]
      payment.billing_contract_id = BillingContract.find_by(contract_num: row["contract_number"]).id
      payment
    end
  end

  def imported_payments
    @imported_payments ||= load_imported_payments
  end

  def find_errors(objects)
    objects.each_with_index do |item, index|
      item.errors.full_messages.map do |msg|
        errors.add :base, "#{(index + 1) / 3}: #{msg}"
      end
    end
  end

  def items
    imported_payments
  end

  def save
    if items.map(&:valid?).all?
      imported_payments.each(&:save!)
      true
    else
      find_errors(items)
      false
    end
  rescue StandardError => e
    errors.add :base, e.message
    false
  end
end
