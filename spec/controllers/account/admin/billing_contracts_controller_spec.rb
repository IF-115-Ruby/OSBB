require 'rails_helper'

RSpec.describe Account::Admin::BillingContractsController, type: :controller do
  render_views
  login_admin

  describe 'when testing controller actions' do
    let!(:company) { create(:company) }
    let!(:billing_contract) { create(:billing_contract) }
    let!(:valid_params) { { contract_num: '12314', company_id: company.id } }
    let!(:invalid_params) { { contract_num: ' ', company_id: company.id } }

    before { sign_in billing_contract.user }

    describe 'GET #index' do
      login_admin
      context 'when rendering html' do
        before { get :index, params: { company_id: billing_contract.company.id } }

        it { is_expected.to respond_with :success }
        it { is_expected.to render_template :index }
        it { expect(assigns(:billing_contracts)).to eq([billing_contract]) }
      end

      context 'when format csv' do
        before { get :index, params: { company_id: billing_contract.company.id }, format: :csv }

        it 'downloads a csv' do
          expect(response.body).to include('company_id', 'contract_num', 'is_active')
          expect(response.headers['Content-Disposition']).to eq('attachment')
          expect(response.headers['Content-Type']).to eq('application/octet-stream')
        end

        it { is_expected.to respond_with :success }
      end

      context 'when format xlsx' do
        before { get :index, params: { company_id: billing_contract.company.id }, format: :xlsx }

        it 'response xlsx content-type' do
          expect(response.headers['Content-Type'])
            .to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
        end

        it { is_expected.to respond_with :success }
      end
    end

    describe 'GET#show' do
      login_admin
      before { get :show, params: { company_id: billing_contract.company.id, id: billing_contract.id } }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :show }
      it { expect(assigns(:billing_contract)).to eq(billing_contract) }
    end

    describe 'GET#new' do
      login_admin
      before { get :new, params: { company_id: company.id } }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { expect(assigns(:billing_contract)).to be_a_new(BillingContract) }
    end

    describe 'POST#create' do
      login_admin
      context 'with valid params' do
        subject do
          post :create, params: { company_id: billing_contract.company.id, billing_contract: valid_params }
        end

        it 'creates a new billing contract' do
          expect do
            subject
          end.to change(BillingContract, :count).by(1)
        end

        it 'redirects to created billing contract' do
          expect(subject).to redirect_to(
            account_admin_company_billing_contract_path(
              billing_contract.company,
              BillingContract.last
            )
          )
        end
      end

      context 'with invalid params' do
        subject do
          post :create, params: { company_id: billing_contract.company.id, billing_contract: invalid_params }
        end

        it 'do not create a new billing_contract' do
          expect do
            subject
          end.to change(BillingContract, :count).by(0)
        end
      end
    end

    describe 'GET#edit' do
      login_admin
      before { get :edit, params: { company_id: billing_contract.company.id, id: billing_contract.id } }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:billing_contract)).to eq(billing_contract) }
    end

    describe 'PUT#update' do
      login_admin
      context 'with valid params' do
        before do
          put :update, params: {
            company_id: billing_contract.company.id,
            id: billing_contract.id,
            billing_contract: valid_params.merge!(contract_num: '0010', is_active: false)
          }
        end

        it { expect(assigns(:billing_contract)).to eq(billing_contract) }
        it { is_expected.to respond_with :redirect }

        it 'redirect to billing contract' do
          expect(response).to redirect_to(
            account_admin_company_billing_contract_path(
              billing_contract.company,
              billing_contract
            )
          )
        end
      end

      context 'with invalid params' do
        it 'does not change billing_contract' do
          expect do
            put :update, params: {
              company_id: billing_contract.company.id,
              id: billing_contract.id,
              billing_contract: invalid_params
            }
          end.not_to change { billing_contract.reload.contract_num }
        end
      end
    end

    describe 'DELETE#destroy' do
      login_admin
      subject do
        delete :destroy, params: { company_id: billing_contract.company.id, id: billing_contract.id }
      end

      it 'destroys the billing contract' do
        expect do
          subject
        end.to change(BillingContract, :count).by(-1)
      end

      it { is_expected.to redirect_to(account_admin_company_billing_contracts_path) }
      it { expect(response).to have_http_status(:success) }
    end
  end

  describe 'import methods block' do
    let!(:company) { create(:company, id: '1') }
    let!(:correct_csv) { { file: fixture_file_upload('files/b-contracts/billing_contracts.csv', 'text/csv') } }
    let!(:correct_xlsx) { { file: fixture_file_upload('files/b-contracts/billing-contracts.xlsx') } }
    let!(:incorrect_csv) { { file: fixture_file_upload('files/b-contracts/billing_contracts-untrue.csv', 'text/csv') } }
    let!(:incorrect_xlsx) { { file: fixture_file_upload('files/b-contracts/billing-contracts-untrue.xlsx') } }
    let!(:incorrect_type_of_file) { { file: fixture_file_upload('files/empty.txt', 'text') } }

    login_user
    login_admin

    describe 'GET#new_import' do
      login_admin
      context 'when rener html' do
        before { get :new_import, params: { company_id: company.id } }

        it { is_expected.to respond_with :success }
        it { is_expected.to render_template :new_import }

        it 'render import button ' do
          expect(response.body).to include("Import Billing Contracts")
        end
      end

      context 'when render xlsx' do
        before { get :new_import, params: { company_id: company.id }, format: :xlsx }

        it { is_expected.to respond_with :success }
      end
    end

    describe 'POST#import' do
      login_admin
      context 'when csv with valid params' do
        before do
          post :import, params: {
            company_id: company.id,
            billing_contracts_import: correct_csv
          }
        end

        it { is_expected.to respond_with :redirect }
        it { expect([:success]).to be_present }
      end

      context 'when correct data check count' do
        subject { post :import, params: { company_id: company.id, billing_contracts_import: correct_csv } }

        it { expect { subject }.to change(BillingContract, :count).by(4) }
      end

      context 'when csv with invalid params' do
        before do
          post :import, params: {
            company_id: company.id,
            billing_contracts_import: incorrect_csv
          }
        end

        it { is_expected.to render_template :new_import }

        it 'raise error' do
          error = 'Please update your spreadsheet and try agin.'
          expect { raise error }.to raise_error(RuntimeError)
        end

        context 'when incorrect data check count' do
          subject { post :import, params: { company_id: company.id, billing_contracts_import: incorrect_csv } }

          it { expect { subject }.to change(BillingContract, :count).by(0) }
        end
      end

      context 'when xlsx with valid params' do
        before do
          post :import, params: {
            company_id: company.id,
            billing_contracts_import: correct_xlsx
          }
        end

        it { is_expected.to respond_with :redirect }
        it { expect([:success]).to be_present }
      end

      context 'when xlsx with invalid params' do
        before do
          post :import, params: {
            company_id: company.id,
            billing_contracts_import: incorrect_xlsx
          }
        end

        it { is_expected.to render_template :new_import }

        it 'raise error' do
          error = 'Please update your spreadsheet and try agin.'
          expect { raise error }.to raise_error(RuntimeError)
        end
      end

      context 'with unknown file type' do
        before do
          post :import, params: {
            company_id: company.id,
            billing_contracts_import: incorrect_type_of_file
          }
        end

        it { is_expected.to render_template :new_import }

        it 'raise error' do
          error = "Unknown file type:"
          expect { raise error }.to raise_error(RuntimeError)
        end
      end

      context 'when file is not selected' do
        before do
          post :import, params: {
            company_id: company.id
          }
        end

        it { is_expected.to render_template :new_import }
        it { expect([:danger]).to be_present }

        it 'raise error' do
          error = 'Field can\'t be empty!'
          expect { raise error }.to raise_error(RuntimeError)
        end
      end
    end
  end
end
