module BillingContractsHelper
  def status_contract(value)
    value ? 'Active' : 'Inactive'
  end
end
