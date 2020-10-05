class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :mobile, :string
    add_column :users, :birthday, :date
    add_column :users, :avatar, :string
    add_column :users, :sex, :integer
    add_column :users, :role, :integer
  end
end
