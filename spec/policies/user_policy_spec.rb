require 'rails_helper'

RSpec.describe UserPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }
  let!(:simple) { create(:user, :simple) }

  permissions :index?, :destroy? do
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :new_assign_osbb?, :assign_osbb? do
    it { is_expected.to permit(simple) }
  end
end
