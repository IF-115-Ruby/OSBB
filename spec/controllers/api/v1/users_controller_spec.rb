require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe 'GET #show' do
    before { get :show, format: :json, params: { id: user.id } }

    it { is_expected.to respond_with :success }
  end
end
