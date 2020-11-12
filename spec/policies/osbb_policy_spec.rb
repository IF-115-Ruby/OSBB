require 'rails_helper'

RSpec.describe OsbbPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }

  permissions :destroy?, :show?, :create?, :new?, :index?, :update?, :edit? do
    it 'prevents deleting yourself' do
      expect(subject).to permit(admin)
    end
  end
end
