class RemoveReferenceCompany < ActiveRecord::Migration[6.0]
  def up
    Account.all.each do |account|
      account.update(accountable_type: "Company", accountable_id: account.company_id)
    end
    safety_assured { remove_reference :accounts, :company, index: true, foreign_key: true }
  end

  def down
    safety_assured { add_reference :accounts, :company, index: true, foreign_key: true }
    Account.where(accountable_type: "Company").each do |account|
      account.update(company_id: account.accountable_id)
    end
  end
end
