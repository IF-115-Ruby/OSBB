require 'rails_helper'

RSpec.describe AdminPolicy, type: :model do
  subject { AdminPolicy }

  let(:current_user) { FactoryBot.build(:user) }
  let(:other_user) { FactoryBot.build(:user) }

  permissions :index?, :update?, :show? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user)
    end
  end

  permissions :show? do
    it 'allows you to see your own profile' do
      expect(subject).to permit(current_user, current_user)
    end
  end

  permissions :destroy? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(current_user, current_user)
    end
  end
end
