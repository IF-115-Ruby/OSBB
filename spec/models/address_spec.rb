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
    context 'when city' do
      it 'require a city' do
        expect(address).to be_valid
      end

      it 'not according to the template' do
        address.city = ''
        expect(address).not_to be_valid
      end
    end

    context 'when country' do
      it 'be valid' do
        expect(address).to be_valid
      end

      it 'not according to the template' do
        address.country = ''
        expect(address).not_to be_valid
      end
    end

    context 'when state' do
      it 'be valid' do
        expect(address).to be_valid
      end

      it 'invalid state' do
        address.state = ''
        expect(address).not_to be_valid
      end
    end

    context 'when street' do
      it 'be valid' do
        expect(address).to be_valid
      end

      it 'invalid street' do
        address.street = ''
        expect(address).not_to be_valid
      end
    end
  end

  describe 'associations' do
    context 'when belong_to' do
      it 'company' do is_expected.to belong_to(:addressable).optional end
    end

    context 'with db column' do
      it 'addressable_id' do is_expected.to have_db_column(:addressable_id).of_type(:integer) end
      it 'addressable_type' do is_expected.to have_db_column(:addressable_type).of_type(:string) end
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
