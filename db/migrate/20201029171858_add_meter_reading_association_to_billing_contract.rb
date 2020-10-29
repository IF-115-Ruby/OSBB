class AddMeterReadingAssociationToBillingContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :meter_readings, :billing_contract, null: true, foreign_key: true
  end
end
