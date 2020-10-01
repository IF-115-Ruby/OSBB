require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company) { FactoryBot.build(:company, name: "IFBut", address_id: 1, company_type: 7, account_id: 7, phone: 2476316898, email: "ifbut@gmail.com", website: "ifbut.com", fax: 9762578517) }

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
    end

    describe 'email' do
      it 'be valid' do
        valid_emails = %w[ifgas@gmail.com]
        valid_emails.each do |email|
          company.email = email
          expect(company).to be_valid
        end
      end

      it 'reject invalid emails' do
        valid_emails = %w[Ifgas.gmail.com]
        valid_emails.each do |email|
          company.email = email
          expect(company).not_to be_valid
        end
      end
    end

    describe 'fax' do
      it 'be valid' do
        company.fax = '7625982189'
        expect(company).to be_valid
      end
    end
  end
end
