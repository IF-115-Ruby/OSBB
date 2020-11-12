require 'rails_helper'

RSpec.describe Account::Admin::CompaniesController, type: :controller do
  login_user
  login_admin
  let!(:company) { create(:company) }
  let!(:valid_params) { attributes_for :company }
  let!(:invalid_params) { { name: ' ' } }

  describe 'GET#index' do
    it 'assigns companies and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:companies)).to eq([company])
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    login_user
    login_admin
    before do
      get :show, params: { id: company.id }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:company)).to eq(company) }
  end

  describe 'GET#new' do
    it 'returns success and assigns company' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'POST#create' do
    login_user
    login_admin
    context 'with valid params' do
      it 'creates a new company' do
        expect do
          post :create, params: { company: valid_params }
        end.to change(Company, :count).by(1)
      end

      it 'redirects to the created company' do
        post :create, params: { company: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(account_admin_company_path(Company.last))
      end
    end

    context 'with invalid params' do
      it 'do not create a new company' do
        expect do
          post :create, params: { company: invalid_params }
        end.not_to change(Company, :count)
      end
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: company.id }
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:company)).to eq(company) }
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: company.id,
                               company: valid_params.merge!(name: 'Example',
                                                            phone: '0123456789',
                                                            email: 'example@email.com') }
      end

      it { expect(assigns(:company)).to eq(company) }
      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(account_admin_company_path(company)) }

      it 'updates company attributes' do
        company.reload
        expect(company.name).to eq(valid_params[:name])
        expect(company.phone).to eq(valid_params[:phone])
        expect(company.email).to eq(valid_params[:email])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change company' do
        expect do
          put :update, params: { id: company.id, company: invalid_params }
        end.not_to change { company.reload.name }
        expect do
          put :update, params: { id: company.id, company: invalid_params }
        end.not_to change { company.reload.phone }
      end
    end
  end

  describe 'DELETE#destroy' do
    login_admin
    it 'destroys the company and redirects to index' do
      expect { delete :destroy, params: { id: company.id } }
        .to change(Company, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(account_admin_companies_path)
      expect(flash[:danger]).to be_present
    end
  end

  describe 'GET#new_import' do
    login_admin
    before { get :new_import }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new_import }
  end

  describe 'POST#import' do
    login_admin
    context 'when present file params' do
      subject { post :import, params: { companies_import: file } }

      let!(:file) { { file: fixture_file_upload('files/companies.csv', 'text/csv') } }

      it { is_expected.to have_http_status(:redirect) }
      it { expect { subject }.to change(Company, :count).by(3) }
      it { expect { subject }.to change(Address, :count).by(3) }
      it { expect { subject }.to change(Account, :count).by(3) }
    end

    context 'when empty params' do
      subject { post :import, params: nil }

      it { is_expected.to have_http_status(:success) }
      it { expect { subject }.not_to change(Company, :count) }
      it { expect { subject }.not_to change(Address, :count) }
      it { expect { subject }.not_to change(Account, :count) }
    end
  end
end
