require 'rails_helper'

RSpec.describe Account, type: :model do
  let!(:account) { FactoryBot.create(:account) }
  let(:edrpou) { account.edrpou }
  let(:iban) { account.iban }
  let(:purpose) { account.purpose }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(account).to be_valid
    end
  end

  describe 'validations' do
    context 'when edrpou' do
      it { is_expected.to allow_value(account.edrpou).for(:edrpou) }

      it { is_expected.not_to allow_value("wrong").for(:edrpou) }
    end

    context 'when iban' do
      it { is_expected.to allow_value(account.iban).for(:iban) }

      it { is_expected.not_to allow_value("wrong").for(:iban) }
    end

    context 'when purpose' do
      it 'not empty' do
        expect(account.purpose).not_to be_empty
      end

      it 'empty' do
        account.purpose = ''
        expect(account.purpose).to be_empty
      end
    end
  end

  describe 'associations' do
    context 'when belong_to' do
      it { is_expected.to belong_to(:company).optional }
    end
  end
end

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  edrpou     :string
#  iban       :string
#  purpose    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_accounts_on_company_id  (company_id)
#  index_accounts_on_edrpou      (edrpou) UNIQUE
#  index_accounts_on_iban        (iban) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
