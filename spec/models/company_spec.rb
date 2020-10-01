require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company) { FactoryBot.build(:company, name: "IFBut", phone: 2476316898, 
                                    email: "ifbut@gmail.com", fax: 9762578517) }

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
        company.phone = '06866666ab'
        expect(company).not_to be_valid
      end

      it 'reject phone that has less 10 digits' do
        company.phone = '012345678'
        expect(company).not_to be_valid
      end

      it 'reject phone that has more 10 digits' do
        company.phone = '01234567899'
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
