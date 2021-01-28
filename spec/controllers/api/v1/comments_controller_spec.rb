require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let!(:osbb) { create(:osbb) }
  let!(:lead) { create(:user, osbb: osbb, role: :lead) }
  let!(:news) { create(:news, user: lead, osbb: osbb) }
  let!(:comment) { create(:comment, commentable: news, user: news.user) }
  let!(:subcomment) { create(:comment, commentable: comment, user: news.user) }

  before { sign_in lead }

  describe 'GET #index' do
    before { get :index, params: { news_id: news.id }, format: :json }

    it { is_expected.to respond_with :success }
    it { is_expected.to render_template('index') }
  end

  describe 'Comment #create' do
    context 'when create comment' do
      before { post :create, params: { body: 'asd', news_id: news.id, page: 1 }, format: :json }

      it { is_expected.to respond_with :success }
    end

    context 'when create subcomment' do
      before { post :create, params: { body: 'asd', news_id: news.id, comment_id: comment.id }, format: :json }

      it { is_expected.to respond_with :success }
    end
  end

  describe 'DELETE #destroy' do
    context 'when delete comment' do
      it 'destroys the comment' do
        expect { delete :destroy, params: { news_id: news.id, id: comment.id } }
          .to change(Comment, :count).by(-2)
      end
    end

    context 'when delete subcomment' do
      it 'destroys the comment' do
        expect { delete :destroy, params: { parent_comment: comment.id, news_id: news.id, id: subcomment.id } }
          .to change(Comment, :count).by(-1)
      end
    end
  end
end
