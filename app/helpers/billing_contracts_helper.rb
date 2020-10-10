module BillingContractsHelper
  def status_contract(value)
    value ? '.active' : '.inactive'
  end
end
