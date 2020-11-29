require 'rails_helper'

RSpec.describe Account::Admin::UsersController, type: :controller do
  let!(:user) { create(:user, :admin) }

  before { sign_in user }

  describe 'GET#index' do
    it 'assigns users and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user and set flash' do
      expect { delete :destroy, params: { id: user.id } }
        .to change(User, :count).by(-1)
      expect(response).to have_http_status(:success)
      expect(flash[:danger]).to be_present
    end
  end
end
