class CreateBillingContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :billing_contracts do |t|
      t.string :contract_num, limit: 50, null: false
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end

    add_index :billing_contracts, :contract_num
  end
end
