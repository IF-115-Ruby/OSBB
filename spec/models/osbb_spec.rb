require 'rails_helper'

RSpec.describe Osbb, type: :model do
  let!(:osbb) { FactoryBot.build(:osbb) }

  it 'has a valid factory' do
    expect(osbb).to be_valid
  end

  describe 'Associations' do
    it { is_expected.to have_many(:users).dependent(:nullify) }
end

  describe 'validations' do
    describe 'name' do
      it 'require a name' do
        osbb.name = ''
        expect(osbb).not_to be_valid
      end

      it 'reject name that less 3 characters' do
        osbb.name = 'le'
        expect(osbb).not_to be_valid
      end

      it 'reject name that more 255 characters' do
        osbb.name = "l" * 256
        expect(osbb).not_to be_valid
      end
    end

    describe 'phone' do
      it 'be valid' do
        osbb.phone = '0123456789'
        expect(osbb).to be_valid
      end

      it 'reject phone that has characters' do
        osbb.phone = '06866666ab'
        expect(osbb).not_to be_valid
      end

      it 'reject phone that has less 10 digits' do
        osbb.phone = '012345678'
        expect(osbb).not_to be_valid
      end

      it 'reject phone that has more 10 digits' do
        osbb.phone = '01234567899'
        expect(osbb).not_to be_valid
      end
    end

    describe 'email' do
      it 'be valid' do
        valid_emails = %w[vasia@gmail.com Misha@mail.ua vania.ivanov@ex.ua]
        valid_emails.each do |email|
          osbb.email = email
          expect(osbb).to be_valid
        end
      end

      it 'reject invalid emails' do
        valid_emails = %w[vasia.gmail.com Misha@a vania.ivanov@ex.]
        valid_emails.each do |email|
          osbb.email = email
          expect(osbb).not_to be_valid
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: osbbs
#
#  id           :bigint           not null, primary key
#  email        :string
#  is_available :boolean
#  name         :string
#  phone        :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_osbbs_on_name  (name)
#
