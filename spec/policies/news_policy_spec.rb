require 'rails_helper'

RSpec.describe NewsPolicy, type: :policy do
  subject { described_class }

  let!(:admin) { create(:user, role: :admin) }
  let!(:lead) { create(:user, role: :lead) }
  let!(:member) { create(:user, role: :members) }
  let!(:simple) { create(:user, role: :simple) }

  permissions :index?, :show?, :create?, :update?, :edit?, :destroy? do
    it "denies access if user is simple" do
      expect(subject).not_to permit(simple)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(admin)
    end

    it "grants access if user is lead" do
      expect(subject).to permit(lead)
    end
  end

  permissions :index?, :show? do
    it "grants access if user is member" do
      expect(subject).to permit(member)
    end
  end

  permissions :create?, :update?, :edit?, :destroy? do
    it "denies access if user is member" do
      expect(subject).not_to permit(member)
    end
  end
end
