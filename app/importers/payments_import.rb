class PaymentsImport < ApplicationsImport
  private

  def load_payments_to_import
    (2..open_spreadsheet.last_row).map do |i|
      row = Hash[[open_spreadsheet.row(1), open_spreadsheet.row(i)].transpose]
      payment = Payment.new
      payment.attributes = row_to_hash row, %w[amount date]
      payment.billing_contract = BillingContract.find_by(contract_num: row["contract_number"])
      payment
    end
  end

  def items_to_import
    @items_to_import ||= load_payments_to_import
  end
end
