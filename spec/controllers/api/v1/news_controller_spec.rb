require 'rails_helper'

RSpec.describe Api::V1::NewsController, type: :controller do
  let!(:osbb) { create(:osbb) }
  let!(:lead) { create(:user, osbb: osbb, role: :lead) }
  let!(:news) { create(:news, user: lead, osbb: osbb) }
  let!(:valid_params) { attributes_for :news }

  before { sign_in lead }

  describe 'GET #index' do
    before { get :index, format: :json }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template('index') }
  end

  describe 'GET #show' do
    before { get :show, format: :json, params: { id: news.id } }

    it { is_expected.to respond_with :success }
  end

  describe 'News #create' do
    context 'when lead creates news with valid parameters' do
      subject { post :create, params: valid_params, format: :json }

      it 'creates a new post' do
        expect { subject }.to change(News, :count).by(+1)
      end

      it { is_expected.to have_http_status(:success) }
    end

    context 'with invalid parameters' do
      subject { post :create, params: { title: '', is_visible: true }, format: :json }

      it 'creates a new news' do
        expect { subject }.to change(News, :count).by(0)
      end
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, format: :json, params: { id: news.id,
                                              post: valid_params.merge!(title: 'Example',
                                                                        short_description: 'Lorem',
                                                                        long_description: 'Sit amet',
                                                                        is_visible: true) }
      end

      it { is_expected.to respond_with :success }
    end

    context 'with invalid params' do
      it 'does not change news' do
        expect do
          put :update, params: { id: news.id, title: ' ' }, format: :json
        end.not_to change { news.reload.title }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the post' do
      expect { delete :destroy, params: { id: news.id } }
        .to change(News, :count).by(-1)
    end
  end
end
