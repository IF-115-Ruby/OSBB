require 'rails_helper'

RSpec.describe BillingContract, type: :model do
  describe 'validations' do
    describe 'contract_num' do
      before { create(:billing_contract) }

      it { is_expected.to validate_presence_of(:contract_num) }
      it { is_expected.to validate_length_of(:contract_num).is_at_most(50) }
      it { is_expected.to validate_uniqueness_of(:contract_num).scoped_to(:company_id).case_insensitive }
    end

    describe 'is_active' do
      it { is_expected.not_to allow_value(nil).for(:is_active) }
    end

    describe 'company_id' do
      it { is_expected.to validate_presence_of(:company_id) }
    end

    describe 'user_id' do
      before { create(:billing_contract) }

      it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:company_id) }
    end
  end

  describe 'associations' do
    context 'when have_many' do
      it { is_expected.to have_many(:bills) }
      it { is_expected.to have_many(:payments) }
    end

    it { is_expected.to belong_to(:company).class_name('Company') }
    it { is_expected.to belong_to(:user).class_name('User').optional }
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
#  company_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_billing_contracts_on_company_id                   (company_id)
#  index_billing_contracts_on_contract_num                 (contract_num)
#  index_billing_contracts_on_contract_num_and_company_id  (contract_num,company_id) UNIQUE
#  index_billing_contracts_on_user_id                      (user_id)
#  index_billing_contracts_on_user_id_and_company_id       (user_id,company_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
