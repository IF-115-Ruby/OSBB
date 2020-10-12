require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  describe '#index' do
    subject { get :index }

    it { is_expected.to be_successful }
  end

  describe 'render view #about' do
    before { get :about }

    it { is_expected.to render_template(:about) }
  end
end
