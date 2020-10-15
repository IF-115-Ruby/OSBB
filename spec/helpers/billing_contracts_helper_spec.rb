require 'spec_helper'

describe BillingContractsHelper do
  describe '#status_contract' do
    it 'returns active when true' do
      expect(helper.status_contract(true)).to eq('Active')
    end

    it 'returns inactive when false' do
      expect(helper.status_contract(false)).to eq('Inactive')
    end
  end
end
