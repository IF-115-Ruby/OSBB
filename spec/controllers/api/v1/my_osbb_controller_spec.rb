require 'rails_helper'

RSpec.describe Api::V1::MyOsbbController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe 'GET #balance' do
    before { get :balance, format: :json }

    it { is_expected.to respond_with :success }
  end
end
