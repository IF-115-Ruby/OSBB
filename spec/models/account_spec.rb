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
    describe 'edrpou' do
      it { is_expected.to allow_value(account.edrpou).for(:edrpou) }

      it { is_expected.not_to allow_value("wrong").for(:edrpou) }
    end

    describe 'iban' do
      it { is_expected.to allow_value(account.iban).for(:iban) }

      it { is_expected.not_to allow_value("wrong").for(:iban) }
    end

    describe 'purpose' do
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
    describe 'with belong_to' do
      it { is_expected.to have_db_column(:accountable_id).of_type(:integer) }
      it { is_expected.to have_db_column(:accountable_type).of_type(:string) }

      it { is_expected.to belong_to(:accountable).optional }
    end
  end
end

# == Schema Information
#
# Table name: accounts
#
#  id               :bigint           not null, primary key
#  accountable_type :string
#  edrpou           :string
#  iban             :string
#  purpose          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  accountable_id   :bigint
#
# Indexes
#
#  index_accounts_on_accountable_type_and_accountable_id  (accountable_type,accountable_id)
#  index_accounts_on_edrpou                               (edrpou) UNIQUE
#  index_accounts_on_iban                                 (iban) UNIQUE
#
