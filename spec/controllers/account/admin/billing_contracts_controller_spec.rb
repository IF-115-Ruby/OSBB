require 'rails_helper'

RSpec.describe Account::Admin::BillingContractsController, type: :controller do
  render_views

  let!(:billing_contract) { create(:billing_contract) }
  let!(:company) { create(:company) }
  let!(:valid_params) { { contract_num: '12314', company_id: company.id } }
  let!(:invalid_params) { { contract_num: ' ', company_id: company.id } }

  before { sign_in billing_contract.user }

  describe 'GET #index' do
    before { get :index, params: { company_id: billing_contract.company.id } }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
    it { expect(assigns(:billing_contracts)).to eq([billing_contract]) }
  end

  describe 'GET#show' do
    before { get :show, params: { company_id: billing_contract.company.id, id: billing_contract.id } }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :show }
    it { expect(assigns(:billing_contract)).to eq(billing_contract) }
  end

  describe 'GET#new' do
    before { get :new, params: { company_id: company.id } }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :new }
    it { expect(assigns(:billing_contract)).to be_a_new(BillingContract) }
  end

  describe 'POST#create' do
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
    before { get :edit, params: { company_id: billing_contract.company.id, id: billing_contract.id } }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :edit }
    it { expect(assigns(:billing_contract)).to eq(billing_contract) }
  end

  describe 'PUT#update' do
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
