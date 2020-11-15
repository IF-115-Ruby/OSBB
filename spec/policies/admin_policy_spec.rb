require 'rails_helper'

RSpec.describe AdminPolicy, type: :model do
  subject { described_class }

  let!(:other_user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  permissions :start_impersonate? do
    it 'denies access if not an admin start_impersonate' do
      expect(subject).to permit(admin)
    end
  end

  permissions :stop_impersonating? do
    it "allows an admin to stop_impersonating" do
      expect(subject).to permit([other_user, admin])
    end
  end
end
