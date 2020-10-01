require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  describe '#index' do
    before { get :index }

    it 'returns success' do
      expect(response).to be_successful
    end
  end
end
