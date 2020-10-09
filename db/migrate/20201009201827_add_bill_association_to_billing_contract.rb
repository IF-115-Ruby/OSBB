class AddBillAssociationToBillingContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :bills, :billing_contract, null: true, foreign_key: true
  end
end
