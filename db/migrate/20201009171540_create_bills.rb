class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.belongs_to :billing_contract, foreign_key: true
      t.datetime :date
      t.decimal :amount

      t.timestamps
    end
  end
end
