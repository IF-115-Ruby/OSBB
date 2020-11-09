module CompanyDataLoader
  def load_entities_to_import(entity)
    (2..open_spreadsheet.last_row).map do |i|
      row = Hash[[open_spreadsheet.row(1), open_spreadsheet.row(i)].transpose]
      entity_object = entity.new
      entity_object.attributes = row_to_hash row, %w[amount date]
      entity_object.billing_contract = BillingContract.find_by(contract_num: row["contract_number"])
      entity_object
    end
  end
end
