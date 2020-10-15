class AddGroupToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :osbb, null: true, foreign_key: true
  end
end
