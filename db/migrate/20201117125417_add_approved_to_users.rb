class AddApprovedToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :approved, :boolean
    change_column_default :users, :approved, false
  end

  def down
    remove_column :users, :approved
  end
end
