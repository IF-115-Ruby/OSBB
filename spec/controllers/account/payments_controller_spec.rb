require 'rails_helper'

RSpec.describe Account::PaymentsController, type: :controller do
  login_user
  let!(:utility_provider) { create(:billing_contract, user: current_user) }
  let!(:wrong_utility_provider) { create(:billing_contract) }

  describe 'when #show format is html' do
    it 'response status 200' do
      get :show, params: { id: utility_provider.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'when utility_provider not found' do
    it 'expected to flash' do
      get :show, params: { id: wrong_utility_provider.id }
      expect(subject.request.flash[:alert]).not_to be_nil
    end
  end

  describe 'when #show format is pdf' do
    it 'format should be pdf and response 200' do
      get :show, format: :pdf, params: { id: utility_provider.id }
      expect(response.media_type).to eq "application/pdf"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET index' do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "response status 200" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
