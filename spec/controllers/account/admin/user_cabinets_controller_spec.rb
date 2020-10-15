require 'rails_helper'
RSpec.describe Account::Admin::UserCabinetsController, type: :controller do
  let!(:user) { create(:user) }

  before { sign_in user }

  describe '#index' do
    subject { get :index }

    it { is_expected.to be_successful }
  end
end
