class ChangeTypeCompanyType < ActiveRecord::Migration[6.0]
  def change
    change_column :companies, :company_type, 'integer USING CAST(company_type AS integer)'
  end
end
