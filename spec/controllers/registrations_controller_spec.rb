require 'rails_helper'

RSpec.describe User::RegistrationsController, type: :controller do
  describe "POST #create" do
    let!(:valid_attributes_user) do
      FactoryBot.build(:user).attributes
                .merge({ password: '123456', confirm_password: '123456' })
    end
    let!(:invalid_attributes_user) { FactoryBot.build(:user).attributes }
    let!(:osbb_valid_params) do
      { name: 'Top OSBB',
        phone: '1231231231',
        email: 'osbb@gmail.com',
        website: 'OsbbTOp.com' }
    end
    let!(:valid_attributes_osbb) do
      valid_attributes_user[:osbb] = osbb_valid_params
      fatributes = { user: valid_attributes_user, flag: true }
      fatributes
    end

    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context "with invalid user params" do
      it "not create a new User" do
        expect do
          post :create, params: { user: invalid_attributes_user }
        end.to change(User, :count).by(0)
      end
    end

    context "with valid user params" do
      it "creates a new User" do
        expect do
          post :create, params: { user: valid_attributes_user }
        end.to change(User, :count).by(1)
      end
    end

    context "with valid osbb and user params" do
      it "creates a new osbb and user" do
        expect do
          post :create, params: valid_attributes_osbb
        end.to change(Osbb, :count).by(1).and change(User, :count).by(1)
      end
    end

    context "with invalid osbb and user params" do
      it "not creates a new osbb and user" do
        invalid = valid_attributes_osbb
        invalid[:user][:osbb] = { name: 'To' }
        expect do
          post :create, params: invalid
        end.to change(Osbb, :count).by(0).and change(User, :count).by(0)
      end
    end
  end
end
