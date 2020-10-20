class AddBillingContractsAssociationsToCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :billing_contracts, :company, index: true, foreign_key: true
  end
end
