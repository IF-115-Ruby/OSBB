require 'rails_helper'

RSpec.describe BillingContractPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }

  permissions :destroy?, :new_import?, :import?, :show?, :create?, :new?, :index?, :update?, :edit? do
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin)
    end
  end
end
