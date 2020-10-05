require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #not_found' do
    it 'must return status code not found' do
      get :not_found
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #server_error' do
    it 'must return status code server error' do
      get :server_error
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'GET #unacceptable' do
    it 'must return status code unacceptable' do
      get :unacceptable
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'Render #not_found' do
    it 'render new page not found' do
      get :not_found
      expect(response).to render_template(:not_found)
    end
  end

  describe 'Render #server_error' do
    it 'render new page server error' do
      get :server_error
      expect(response).to render_template(:server_error)
    end
  end

  describe 'Render #unacceptable' do
    it 'render new page unacceptable' do
      get :unacceptable
      expect(response).to render_template(:unacceptable)
    end
  end
end
