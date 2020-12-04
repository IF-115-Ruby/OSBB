require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  let!(:user) { create(:user, role: :simple, address: create(:address)) }
  let!(:osbb) { create(:osbb, id: 13) }
  let!(:lead) { create(:user, :lead, osbb_id: osbb.id) } # rubocop:disable RSpec/LetSetup
  let!(:valid_params) { attributes_for :user }
  let!(:invalid_params) { { first_name: ' ', last_name: ' ' } }
  let!(:address_valid_params) { attributes_for :address }
  let!(:address_invalid_params) { { country: '', city: '' } }

  before { sign_in user }

  describe 'GET#show' do
    before do
      get :show, params: { id: user.id }
    end

    it 'returns success and assigns user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET#edit' do
    before do
      get :edit, params: { id: user.id }
    end

    it 'returns http success and assign user' do
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: user.id,
                               user: valid_params.merge!(first_name: 'Example',
                                                         last_name: 'Test',
                                                         email: 'example@email.com') }
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(edit_account_user_path(user))
      end

      it 'updates user attributes' do
        user.reload
        expect(user.first_name).to eq(valid_params[:first_name])
        expect(user.last_name).to eq(valid_params[:last_name])
        expect(user.email).to eq(valid_params[:email])
        expect(flash[:success]).to be_present
      end
    end

    context "with valid address" do
      let!(:valid_attributes_address) { valid_params[:address_attributes] = address_valid_params }

      before do
        put :update, params: { id: user.id, user: valid_params }
      end

      it 'updates address attributes' do
        user.reload
        expect(user.address.country).to eq(valid_attributes_address[:country])
        expect(user.address.state).to eq(valid_attributes_address[:state])
        expect(user.address.city).to eq(valid_attributes_address[:city])
        expect(user.address.street).to eq(valid_attributes_address[:street])
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid address" do
      let(:invalid_attributes_address) { valid_params[:address_attributes] = address_invalid_params }

      it 'does not change address attributes' do
        expect do
          put :update, params: { id: user.id, user: valid_params }
        end.not_to change { user.reload.address.country }
      end
    end

    context 'with invalid params' do
      it 'does not change user' do
        expect do
          put :update, params: { id: user.id, user: invalid_params }
        end.not_to change { user.reload.first_name }
        expect do
          put :update, params: { id: user.id, user: invalid_params }
        end.not_to change { user.reload.last_name }
      end
    end
  end

  describe 'GET#new_assign_osbb' do
    it 'returns success and renders new_assign_osbb template' do
      get :new_assign_osbb, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new_assign_osbb)
    end
  end

  describe 'PUT#assign_osbb' do
    before do
      put :assign_osbb, params: { id: user.id, user: { osbb_id: osbb.name } }
    end

    it { is_expected.to respond_with :redirect }
    it { is_expected.to set_flash }
  end
end
