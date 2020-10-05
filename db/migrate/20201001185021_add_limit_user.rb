class AddLimitUser < ActiveRecord::Migration[6.0]
  def up
    change_table :users do |t|
      t.change :first_name, :string, limit: 50, null: false
      t.change :last_name, :string, limit: 50, null: false
      t.change :email, :string, limit: 254, null: false
    end
    end

  def down
    change_table :users do |t|
      t.change :first_name, limit: nil, null: true
      t.change :last_name, limit: nil, null: true
      t.change :email, limit: nil, null: true
    end
  end
end
