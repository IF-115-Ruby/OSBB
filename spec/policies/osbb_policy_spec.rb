require 'rails_helper'

RSpec.describe OsbbPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }
  let!(:simple) { create(:user, :simple) }

  permissions :destroy?, :show?, :index?, :update?, :edit? do
    it 'prevents deleting yourself' do
      expect(subject).to permit(admin)
    end
  end

  permissions :create?, :new? do
    it { is_expected.to permit(simple) }
  end
end
