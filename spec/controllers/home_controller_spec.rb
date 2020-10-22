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

  describe 'render view #custom_error' do
    before { get :custom_error }

    it { is_expected.to render_template(:custom_error) }
  end

  # rubocop:disable RSpec/UnspecifiedException
  describe 'respond to #random_error' do
    it { expect { get :random_error }.to raise_error }
  end
  # rubocop:enable RSpec/UnspecifiedException
end
