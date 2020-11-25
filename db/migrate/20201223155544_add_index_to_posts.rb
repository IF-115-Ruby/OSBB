class AddIndexToPosts < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :posts, :is_visible, algorithm: :concurrently
  end
end
