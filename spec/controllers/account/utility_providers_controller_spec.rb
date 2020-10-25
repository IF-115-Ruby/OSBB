require 'rails_helper'

RSpec.describe Account::UtilityProvidersController, type: :controller do
  render_views

  let!(:utility_provider) { create(:billing_contract) }
  let!(:utility_provider2) { create(:billing_contract, user: nil) }
  let!(:company) { create(:company) }

  before { sign_in utility_provider.user }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
    it { expect(assigns(:utility_providers)).to eq([utility_provider]) }
  end

  describe 'GET #search' do
    before { get :search }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :companies }
  end

  describe 'GET #new' do
    context 'when is contract_num' do
      before { get :new, params: { company_id: company.id } }

      it { is_expected.to use_before_action(:set_company) }
      it { is_expected.to respond_with :success }
      it { expect(assigns(:billing_contract)).to be_a_new(BillingContract) }
    end

    context 'when is not contract_num' do
      before { get :new, params: { company_id: utility_provider.company.id } }

      it { is_expected.to use_before_action(:set_company) }
      it { is_expected.to respond_with :redirect }
      it { is_expected.to set_flash }
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        put :update, params: {
          id: utility_provider2.id,
          company_id: utility_provider2.company_id,
          billing_contract: {
            contract_num: utility_provider2.contract_num
          }
        }
      end

      it { is_expected.to respond_with :redirect }
      it { is_expected.to set_flash }
    end

    context 'with invalid params' do
      before do
        put :update, params: {
          id: utility_provider.id,
          company_id: utility_provider2.company_id,
          billing_contract: {
            contract_num: utility_provider.contract_num
          }
        }
      end

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { is_expected.to set_flash }
    end
  end

  describe 'PUT #disassociate' do
    before { put :disassociate, params: { id: utility_provider.id } }

    it { expect(assigns(utility_provider.user_id)).to eq(nil) }
    it { is_expected.to respond_with :redirect }
  end
end
