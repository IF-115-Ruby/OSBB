class AddIndexToBillingContracts < ActiveRecord::Migration[6.0]
  def change
    add_index :billing_contracts, [:contract_num, :company_id], unique: true
    add_index :billing_contracts, [:user_id, :company_id], unique: true
  end
end
