require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  before { get :about }

  describe '#index' do
    subject { get :index }

    it { is_expected.to be_successful }
  end

  describe 'render view #about' do
    it { is_expected.to render_template(:about) }
  end
end
