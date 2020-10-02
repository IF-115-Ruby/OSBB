class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :edrpou
      t.string :iban
      t.text :purpose

      t.timestamps
    end
  end
end
