require 'rails_helper'

RSpec.describe Account::Admin::OsbbsController, type: :controller do
  let!(:osbb) { create(:osbb) }
  let!(:valid_params) { attributes_for :osbb }
  let!(:invalid_params) { { name: '' } }

  describe 'GET#new' do
    login_user
    it 'returns success and assigns osbb' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:osbb)).to be_a_new(Osbb)
    end
  end

  describe 'POST#create' do
    login_user
    context 'with valid params' do
      it 'creates a new osbb' do
        expect do
          post :create, params: { osbb: valid_params }
        end.to change(Osbb, :count).by(1)
      end

      it 'redirects to the created osbb' do
        post :create, params: { osbb: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(osbb_path(Osbb.last))
      end
    end

    context 'with invalid params' do
      it 'do not create a new osbb' do
        expect do
          post :create, params: { osbb: invalid_params }
        end.not_to change(Osbb, :count)
      end
    end
  end

  describe 'GET#edit' do
    login_user
    before do
      get :edit, params: { id: osbb.id }
    end

    it 'returns http success and assigns osbb' do
      expect(response).to have_http_status(:success)
      expect(assigns(:osbb)).to eq(osbb)
    end
  end

  describe 'PUT#update' do
    login_user
    context 'with valid params' do
      before do
        put :update, params: { id: osbb.id,
                               osbb: valid_params.merge!(name: 'Example',
                                                         phone: '0123456789',
                                                         email: 'example@email.com') }
      end

      it 'assigns the osbb' do
        expect(assigns(:osbb)).to eq(osbb)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(osbb_path(osbb))
      end

      it 'updates osbb attributes' do
        osbb.reload
        expect(osbb.name).to eq(valid_params[:name])
        expect(osbb.phone).to eq(valid_params[:phone])
        expect(osbb.email).to eq(valid_params[:email])
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'does not change osbb' do
        expect do
          put :update, params: { id: osbb.id, osbb: invalid_params }
        end.not_to change { osbb.reload.name }
        expect do
          put :update, params: { id: osbb.id, osbb: invalid_params }
        end.not_to change { osbb.reload.phone }
      end
    end
  end

  describe 'DELETE#destroy' do
    login_user
    it 'destroys the osbb and redirects to index' do
      expect { delete :destroy, params: { id: osbb.id } }
        .to change(Osbb, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to([:osbbs])
      expect(flash[:danger]).to be_present
    end
  end
end
