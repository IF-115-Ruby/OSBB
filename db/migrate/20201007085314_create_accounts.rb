class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :edrpou, index: {unique: true}
      t.string :iban,  index: {unique: true}
      t.text :purpose

      t.timestamps
    end
  end
end
