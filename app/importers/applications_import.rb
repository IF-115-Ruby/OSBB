class ApplicationsImport
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) } if attributes&.key?(:file)
  end

  def perform
    return false if field_empty?

    items_to_import.each(&:save!) if validate_data?
  rescue StandardError => e
    errors.add :base, e.message
    false
  end

  private

  def field_empty?
    unless file
      errors.add :base, 'Field can\'t be empty!'
      true
    end
  end

  def open_spreadsheet
    @open_spreadsheet ||= case File.extname(file.original_filename)
                          when ".csv" then Roo::CSV.new(file.path)
                          when ".xls" then Roo::Excel.new(file.path)
                          when ".xlsx" then Roo::Excelx.new(file.path)
                          else raise "Unknown file type: #{file.original_filename}"
                          end
  end

  def row_to_hash(row, attributes)
    row.to_hash.select { |k| attributes.include? k }.with_indifferent_access
  end

  def validate_data?; end
end
