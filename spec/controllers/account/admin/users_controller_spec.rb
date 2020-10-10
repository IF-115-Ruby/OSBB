require 'rails_helper'

RSpec.describe Account::Admin::UsersController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe 'GET#index' do
    it 'assigns users and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the user and redirects to index' do
      expect { delete :destroy, params: { id: user.id } }
        .to change(User, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(account_admin_users_path)
      expect(flash[:danger]).to be_present
    end
  end
end
