class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.references :user
      t.references :osbb
      t.string :title
      t.string :short_description
      t.text :long_description
      t.boolean :is_visible
      t.boolean :is_private

      t.timestamps
    end
  end
end
