require 'rails_helper'

RSpec.describe UserPolicy, type: :model do
  subject { described_class }

  let!(:other_user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  permissions :index?, :destroy? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(other_user)
    end

    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end
end
