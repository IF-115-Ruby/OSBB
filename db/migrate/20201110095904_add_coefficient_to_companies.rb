class AddCoefficientToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :payment_coefficient, :decimal
  end
end
