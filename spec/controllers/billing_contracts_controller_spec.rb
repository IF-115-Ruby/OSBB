require 'rails_helper'

RSpec.describe BillingContractsController, type: :controller do
  render_views
  let!(:billing_contract) { create(:billing_contract) }
  let!(:valid_params) { attributes_for :billing_contract }
  let!(:invalid_params) { { contract_num: ' ' } }

  describe 'GET #index' do
    it 'assigns billing contracts and renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:billing_contracts)).to eq([billing_contract])
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    it 'returns success and assigns billing contract' do
      get :show, params: { id: billing_contract.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:billing_contract)).to eq(billing_contract)
    end
  end

  describe 'GET#new' do
    it 'returns success and assigns billing contract' do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:billing_contract)).to be_a_new(BillingContract)
    end
  end

  describe 'POST#create' do
    context 'with valid params' do
      it 'creates a new billing_contract' do
        expect do
          post :create, params: { billing_contract: valid_params }
        end.to change(BillingContract, :count).by(1)
      end

      it 'redirects to the created billing_contract' do
        post :create, params: { billing_contract: valid_params }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(billing_contract_path(BillingContract.last))
      end
    end

    context 'with invalid params' do
      it 'do not create a new billing_contract' do
        expect do
          post :create, params: { billing_contract: invalid_params }
        end.not_to change(BillingContract, :count)
      end
    end
  end

  describe 'GET#edit' do
    it 'returns http success and assign billing_contract' do
      get :edit, params: { id: billing_contract.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:billing_contract)).to eq(billing_contract)
    end
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update, params: { id: billing_contract.id,
                               billing_contract: valid_params.merge!(contract_num: '0010', is_active: false) }
      end

      it 'assigns the billing_contract' do
        expect(assigns(:billing_contract)).to eq(billing_contract)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(billing_contract_path(billing_contract))
      end

      it 'updates billing_contract attributes' do
        billing_contract.reload
        expect(billing_contract.contract_num).to eq(valid_params[:contract_num])
        expect(billing_contract.is_active).to eq(valid_params[:is_active])
      end
    end

    context 'with invalid params' do
      it 'does not change billing_contract' do
        expect do
          put :update, params: { id: billing_contract.id, billing_contract: invalid_params }
        end.not_to change { billing_contract.reload.contract_num }
      end
    end
  end

  describe 'DELETE#destroy' do
    it 'destroys the billing_contract and redirects to index' do
      expect { delete :destroy, params: { id: billing_contract.id } }
        .to change(BillingContract, :count).by(-1)
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(billing_contracts_path)
      expect(flash[:danger]).to be_present
    end
  end
end
