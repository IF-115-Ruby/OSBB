require 'rails_helper'

RSpec.describe Api::V1::NewsController, type: :controller do
  let!(:osbb) { create(:osbb) }
  let!(:user) { create(:user, osbb: osbb) }
  let!(:news) { create(:news) }

  before { sign_in user }

  describe 'GET #index' do
    before { get :index, format: :json }

    it { is_expected.to respond_with :success }
  end

  describe 'GET #show' do
    before { get :show, format: :json, params: { id: news.id } }

    it { is_expected.to respond_with :success }
  end
end
