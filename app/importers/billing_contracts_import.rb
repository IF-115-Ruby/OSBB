class BillingContractsImport < ApplicationsImport
  private

  def load_billing_contracts_to_import
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(2)
    (3..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      billing_contract = BillingContract.new
      billing_contract.attributes = row_to_hash row, %w[contract_num is_active company_id]
      billing_contract
    end
  end

  def items_to_import
    @items_to_import ||= load_billing_contracts_to_import
  end
end
