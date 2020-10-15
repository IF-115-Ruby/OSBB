class ChangeSexToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :sex, 'integer USING CAST(sex AS integer)'
  end

  def down
    change_column :users, :sex, :string
  end
end
