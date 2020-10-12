require 'rails_helper'

RSpec.describe Address, type: :model do
  let!(:address) { FactoryBot.build(:address) }
  let(:city) { address.city }
  let(:country) { address.country }
  let(:state) { address.state }
  let(:street) { address.street }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(address).to be_valid
    end
  end

  describe 'validations' do
    describe 'city' do
      it { is_expected.to allow_value(address.city).for(:city) }

      it { is_expected.not_to allow_value('').for(:city) }
    end

    describe 'country' do
      it { is_expected.to allow_value(address.country).for(:country) }

      it { is_expected.not_to allow_value('').for(:country) }
    end

    describe 'state' do
      it { is_expected.to allow_value(address.state).for(:state) }

      it { is_expected.not_to allow_value('').for(:state) }
    end

    describe 'street' do
      it { is_expected.to allow_value(address.street).for(:street) }

      it { is_expected.not_to allow_value('').for(:street) }
    end
  end

  describe 'associations' do
    context 'with belong_to' do
      it { is_expected.to belong_to(:addressable).optional }
    end

    context 'with db column' do
      it { is_expected.to have_db_column(:addressable_id).of_type(:integer) }
      it { is_expected.to have_db_column(:addressable_type).of_type(:string) }
    end
  end
end

# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  city             :string
#  country          :string
#  state            :string
#  street           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint
#
# Indexes
#
#  index_addresses_on_addressable_type_and_addressable_id  (addressable_type,addressable_id)
#
