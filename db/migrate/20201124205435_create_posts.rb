class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_description
      t.text :long_description
      t.string :image
      t.boolean :is_visible
      t.boolean :is_private
      t.belongs_to :osbb, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
