require 'rails_helper'

RSpec.describe Api::V1::NeighborsController, type: :controller do
  render_views

  let!(:approved_accept_data) { { approved: 'true', role: 'members' } }
  let!(:osbb) { create(:osbb) }
  let!(:neighbor) { create(:user, osbb: osbb) }

  login_user

  describe 'GET #index' do
    before { get :index, format: :json }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template :index }
  end

  describe 'PUT#update' do
    before do
      put :update, format: :json, params: { id: neighbor.id, neighbor: approved_accept_data }
    end

    it 'assigns the user' do
      expect(assigns(:neighbor)).to eq(neighbor)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET#search' do
    before { User.reindex }

    it 'returns successful when get search with params' do
      get :search, xhr: true, params: { approved: 'true' }, format: :json

      expect(response).to be_successful
    end

    it 'returns success when searchs approved neighbors' do
      User.search('true')
      expect(response).to have_http_status(:success)
    end

    it 'returns success when searchs non-approved neighbors' do
      User.search('false')
      expect(response).to have_http_status(:success)
    end
  end
end
