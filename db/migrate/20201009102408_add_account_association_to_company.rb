class AddAccountAssociationToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts, :company, null: true, foreign_key: true
  end
end
