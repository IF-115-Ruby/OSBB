require 'rails_helper'

RSpec.describe AdminPolicy, type: :model do
  subject { described_class }

  let!(:current_user) { FactoryBot.build(:user) }
  let!(:other_user) { FactoryBot.build(:user) }
  let!(:admin) { FactoryBot.build(:user, :admin) }

  permissions :index?, :update?, :edit? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(current_user, other_user)
    end
  end

  permissions :show?, :create?, :new? do
    it 'allows you to see your own profile' do
      expect(subject).to permit(current_user, current_user)
    end

    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(current_user, current_user)
    end

    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, other_user)
    end
  end
end
