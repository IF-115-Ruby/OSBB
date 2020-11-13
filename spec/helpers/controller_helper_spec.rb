require 'spec_helper'
require 'rails_helper'

describe ControllerHelper do
  describe '#successful_update' do
    let(:message) { "profile updated" }

    it 'returns success update flash' do
      expect(helper.successful_update(message)).to eq(message)
    end
  end
end
