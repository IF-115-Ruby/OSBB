require 'rails_helper'

RSpec.describe BillingContract, type: :model do
  let!(:billing_contract) { FactoryBot.build(:billing_contract) }

  it 'has a valid factory' do
    expect(billing_contract).to be_valid
  end

  describe 'validations' do
    describe 'contract_num' do
      it { is_expected.to validate_presence_of(:contract_num) }
      it { is_expected.to validate_length_of(:contract_num).is_at_most(50) }
    end

    describe 'is_active' do
      it { is_expected.not_to allow_value(nil).for(:is_active) }
    end
  end

  describe 'associations' do
    context 'when have_many' do
      it { is_expected.to have_many(:bills) }
      it { is_expected.to have_many(:payments) }
    end
  end
end

# == Schema Information
#
# Table name: billing_contracts
#
#  id           :bigint           not null, primary key
#  contract_num :string(50)       not null
#  is_active    :boolean          default(TRUE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_billing_contracts_on_contract_num  (contract_num)
#
