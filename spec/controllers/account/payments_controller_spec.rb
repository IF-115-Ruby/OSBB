require 'rails_helper'

RSpec.describe Account::PaymentsController, type: :controller do
  let!(:payment) { create(:payment) }
  let!(:invalid_id) { { id: '' } }

  before { sign_in payment.billing_contract.user }

  describe 'GET#index' do
    it 'response status 200 and renders the index template' do
      get :index, params: { utility_provider_id: payment.billing_contract.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    it 'response status 200 when format is html' do
      get :show, params: { id: payment.id, utility_provider_id: payment.billing_contract.id, format: :html }
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq 'application/pdf'
    end

    it 'response status 200 format is pdf' do
      get :show, params: { id: payment.id, utility_provider_id: payment.billing_contract.id, format: :pdf }
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq 'application/pdf'
    end
  end

  describe 'when payment not found' do
    it 'expected to flash and redirect' do
      get :show, params: { id: invalid_id, utility_provider_id: payment.billing_contract.id }
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to(account_utility_provider_payments_path)
    end
  end
end
