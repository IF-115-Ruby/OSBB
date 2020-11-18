class RemoveReferenceCompany < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_reference :accounts, :company, index: true, foreign_key: true }
  end
end
