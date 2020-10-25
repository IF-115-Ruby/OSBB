require 'rails_helper'

RSpec.describe Account::Admin::CompaniesImportsController, type: :controller do
  login_user

  let!(:correct_file) { { file: fixture_file_upload('files/companies.csv', 'text/csv') } }
  let!(:incorrect_file) { { file: fixture_file_upload('files/companies-incorrect.csv', 'text/csv') } }
  let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/not-csv', 'text') } }

  describe 'GET#new' do
    before { get :new }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new }
  end

  describe 'POST#create' do
    context 'with valid values' do
      before do
        post :create, params: {
          companies_import: correct_file
        }
      end

      it { is_expected.to respond_with :redirect }
      it { expect(flash[:success]).to be_present }
    end
  end

  context 'with invalid values' do
    before do
      post :create, params: {
        companies_import: incorrect_file
      }
    end

    it { is_expected.to render_template :new }
  end

  context 'with invalid type of file' do
    before do
      post :create, params: {
        companies_import: incorrect_type_of_file
      }
    end

    it { is_expected.to render_template :new }
  end

  context 'with empty params' do
    before do
      post :create, params: nil
    end

    it { is_expected.to respond_with :redirect }
    it { expect(flash[:danger]).to be_present }
  end
end
