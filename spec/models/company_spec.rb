require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company) do
    FactoryBot.build(:company, name: "IFBut", phone: 2_476_316_898,
                               email: "ifbut@gmail.com", fax: 9_762_578_517)
  end

  describe 'validations' do
    describe 'name' do
      it 'require a name' do
        company.name = ''
        expect(company).not_to be_valid
      end

      it 'reject name that more 50 characters' do
        company.name = "i" * 51
        expect(company).not_to be_valid
      end
    end

    describe 'phone' do
      it 'be valid' do
        company.phone = '9962741981'
        expect(company).to be_valid
      end

      it 'reject phone that has characters' do
        company.phone = '76535786ab'
        expect(company).not_to be_valid
      end

      it 'reject phone that has less 10 digits' do
        company.phone = '012345678'
        expect(company).not_to be_valid
      end

      it 'reject phone that has more 10 digits' do
        company.phone = '0123456789'
        expect(company).not_to be_valid
      end
    end

    describe 'email' do
      it 'require a email' do
        company.email = ''
        expect(company).not_to be_valid
      end

      it 'be valid' do
        company.email = "ifgas@gmail.com"
        expect(company).to be_valid
      end

      it 'reject invalid emails' do
        company.email = "Ifgas.gmail.com"
        expect(company).not_to be_valid
      end
    end
  end
end
