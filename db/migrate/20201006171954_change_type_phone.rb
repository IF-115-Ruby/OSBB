class ChangeTypePhone < ActiveRecord::Migration[6.0]
  def up
    change_table :companies do |t|
      t.change :phone, :string, limit: 14
    end
  end

  def down
    change_table :companies do |t|
      t.change :phone, :integer
    end
  end
end
