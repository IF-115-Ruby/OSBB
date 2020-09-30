require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  describe '#index' do
    describe "returns status codes" do
      it 'seccess' do
        get :index
        expect(response.code).to eq '200'
      end
    end
  end
end
