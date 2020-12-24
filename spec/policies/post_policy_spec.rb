require 'rails_helper'

RSpec.describe PostPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }
  let!(:lead) { create(:user, :lead) }
  let!(:member) { create(:user, :member) }
  let!(:simple) { create(:user, :simple) }

  permissions :index?, :create?, :show?, :update?, :destroy? do
    it { is_expected.to permit(admin) }
    it { is_expected.to permit(lead) }
    it { is_expected.to permit(member) }
    it { is_expected.not_to permit(simple) }
  end
end
