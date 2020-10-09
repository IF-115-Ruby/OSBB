class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.bigint :biling_contract_id
      t.datetime :date
      t.float :amount

      t.timestamps
      t.index :biling_contract_id
    end
  end
end
