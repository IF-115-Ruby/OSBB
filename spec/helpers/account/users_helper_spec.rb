require 'spec_helper'
require 'rails_helper'

describe Account::UsersHelper do
  describe '#options_for_sex' do
    it 'returns options with translations' do
      expected_result = [%w[Male male], %w[Female female], ['Not set', 'no_sex']]
      expect(helper.options_for_sex).to eq(expected_result)
    end
  end
end
