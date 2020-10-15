class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.bigint :billing_contract_id
      t.datetime :date
      t.decimal :amount

      t.timestamps
      t.index :billing_contract_id
    end
  end
end
