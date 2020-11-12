require 'rails_helper'

RSpec.describe Account::NewsController, type: :controller do
  render_views

  let!(:osbb) { create(:osbb) }
  let!(:lead) { create(:user, role: :lead, osbb: osbb) }
  let!(:simple) { create(:user, role: :simple, osbb: osbb) }
  let!(:news) { create(:news, user: lead, osbb: osbb) }
  let!(:valid_params) { attributes_for :news }
  let!(:invalid_params) { { title: '' } }

  before { sign_in lead }

  describe "when user is not authorized" do
    it "raises an error and redirect" do
      sign_in simple

      get :index
      expect(flash[:alert]).to be_present
      expect(response).to redirect_to(request.referer || home_path)
    end
  end

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET#show' do
    before do
      get :show, params: { id: news.id }
    end

    it 'returns success and assigns news' do
      expect(response).to have_http_status(:success)
      expect(assigns(:news)).to eq([news])
    end
  end

  describe 'GET#new' do
    it 'returns success and assigns news' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:post)).to be_a_new(News)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new news' do
        expect do
          post :create, params: { news: valid_params }
        end.to change(News, :count).by(1)
      end

      it 'redirects to news index path' do
        post :create, params: { news: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(account_news_index_path)
      end
    end

    context 'with invalid params' do
      it 'do not create a new news' do
        expect do
          post :create, params: { news: invalid_params }
        end.not_to change(News, :count)
      end
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: news.id,
                               news: valid_params.merge!(title: 'Test',
                                                         short_description: 'New description',
                                                         long_description: '<p>New text</p>') }
      end

      it 'assigns the news' do
        expect(assigns(:news)).to eq([news])
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(account_news_path(news))
      end

      it 'updates news attributes' do
        news.reload
        expect(news.title).to eq(valid_params[:title])
        expect(news.short_description).to eq(valid_params[:short_description])
        expect(news.long_description).to eq(valid_params[:long_description])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change news' do
        expect do
          put :update, params: { id: news.id, news: invalid_params }
        end.not_to change { news.reload.title }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the news and redirects to index' do
      expect { delete :destroy, params: { id: news.id } }
        .to change(News, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(account_news_index_path)
      expect(flash[:danger]).to be_present
    end
  end
end
