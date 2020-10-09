class AddPaymentAssociationToBillingContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :billing_contract, null: true, foreign_key: true
  end
end
