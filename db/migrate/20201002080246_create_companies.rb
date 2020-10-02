class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :company_type
      t.integer :phone
      t.string :email
      t.string :website
      t.integer :fax

      t.timestamps
      t.index :name
    end
  end
end
