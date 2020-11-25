require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let!(:osbb) { create(:osbb) }
  let!(:lead) { create(:user, osbb: osbb, role: :lead) }
  let!(:member) { create(:user, osbb: osbb, role: :member) }
  let!(:posts) { create(:post, user: lead, osbb: osbb) }
  let!(:valid_params) { attributes_for :post }

  before { sign_in lead }

  describe 'GET #index' do
    before { get :index, format: :json }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template('index') }
  end

  describe 'Post #create' do
    context 'when lead creates post with valid parameters' do
      subject { post :create, params: valid_params, format: :json }

      it 'creates a new post' do
        expect { subject }.to change(Post, :count).by(+1)
      end

      it { is_expected.to have_http_status(:success) }
    end

    context 'when member creates post with valid parameters' do
      subject { post :create, params: valid_params, format: :json }

      before { sign_in member }

      it 'creates a new post' do
        expect { subject }.to change(Post, :count).by(+1)
      end

      it { is_expected.to have_http_status(:success) }
    end

    context 'with invalid parameters' do
      subject { post :create, params: { title: 'Test', is_visible: true }, format: :json }

      it 'creates a new post' do
        expect { subject }.to change(Post, :count).by(0)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, format: :json, params: { id: posts.id,
                                              post: valid_params.merge!(
                                                title: 'Example',
                                                short_description: 'Lorem',
                                                long_description: 'Sit amet',
                                                is_visible: true
                                              ) }
      end

      it { is_expected.to respond_with :success }

      it 'assigns the post' do
        expect(assigns(:post)).to match(posts)
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: posts.id, title: ' ' }, format: :json
      end

      it { is_expected.to respond_with :unprocessable_entity }
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the post' do
      expect { delete :destroy, params: { id: posts.id } }
        .to change(Post, :count).by(-1)
    end
  end
end
