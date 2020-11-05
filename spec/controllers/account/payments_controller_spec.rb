require 'rails_helper'

RSpec.describe Account::PaymentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:utility_provider) { create(:billing_contract, user: user) }

  before { sign_in user }

  describe 'when #show format is html' do
    it 'response status 200' do
      get :show, params: { id: utility_provider.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'when #show format is pdf' do
    it 'format should be pdf and response 200' do
      get :show, format: :pdf, params: { id: utility_provider.id }
      expect(response.media_type).to eq "application/pdf"
      expect(response).to have_http_status(:success)
    end
  end
end
