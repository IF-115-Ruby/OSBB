class CreateOsbbs < ActiveRecord::Migration[6.0]
  def change
    create_table :osbbs do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :website
      t.boolean :is_available

      t.timestamps
      t.index :name
    end
  end
end
