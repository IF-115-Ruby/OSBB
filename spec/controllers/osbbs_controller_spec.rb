require 'rails_helper'

RSpec.describe OsbbsController, type: :controller do
  let!(:osbb) { create(:osbb) }

  describe 'GET#index' do
    it 'assigns osbbs and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:osbbs)).to eq([osbb])
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    before do
      get :show, params: { id: osbb.id }
    end

    it 'returns success and assigns osbb' do
      expect(response).to have_http_status(:success)
      expect(assigns(:osbb)).to eq(osbb)
    end
  end
end
