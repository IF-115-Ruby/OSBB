class AddBillingContractsAssociationsToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :billing_contracts, :user, index: true, foreign_key: true, null: true
  end
end
