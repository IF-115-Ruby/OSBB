require 'rails_helper'

RSpec.describe AdminPolicy, type: :model do
  subject { described_class }

  let!(:other_user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  permissions :start_impersonate?, :stop_impersonating? do
    it 'denies access if not an admin' do
      expect(subject).not_to permit(other_user)
    end

    it "allows an admin to delete any user" do
      expect(subject).to permit(admin)
    end
  end
end
