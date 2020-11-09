require 'rails_helper'

RSpec.describe Account::MeterReadingsController, type: :controller do
  render_views

  let!(:utility_provider) { create(:billing_contract) }
  let!(:valid_params) { attributes_for :meter_reading }
  let!(:invalid_params) { { value: '', date: '' } }

  login_user

  describe 'GET #index' do
    before { get :index, params: { utility_provider_id: utility_provider.id } }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end

  describe 'GET#new' do
    before { get :new, params: { utility_provider_id: utility_provider.id } }

    it 'returns success and assigns meter_reading' do
      expect(response).to have_http_status(:success)
      expect(assigns(:meter_reading)).to be_a_new(MeterReading)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new meter_reading' do
        expect do
          post :create, params: { utility_provider_id: utility_provider.id, meter_reading: valid_params }
        end.to change(MeterReading, :count).by(1)
      end

      it 'redirects to the utility_providers' do
        post :create, params: { utility_provider_id: utility_provider.id, meter_reading: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(account_utility_provider_path(utility_provider))
      end
    end

    context 'with invalid params' do
      it 'do not create a new meter_reading' do
        expect do
          post :create, params: { utility_provider_id: utility_provider.id, meter_reading: invalid_params }
        end.not_to change(MeterReading, :count)
      end
    end
  end
end
