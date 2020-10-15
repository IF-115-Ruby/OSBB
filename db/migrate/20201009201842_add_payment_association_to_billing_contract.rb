class AddPaymentAssociationToBillingContract < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :billing_contracts, null: false, foreign_key: true
  end
end
