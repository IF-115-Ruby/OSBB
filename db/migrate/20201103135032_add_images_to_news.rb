class AddImagesToNews < ActiveRecord::Migration[6.0]
  def change
    add_column :news, :image, :string
  end
end
