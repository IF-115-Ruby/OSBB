require 'rails_helper'

RSpec.describe BillPolicy, type: :model do
  subject { described_class }

  let!(:other_user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  permissions :new_import?, :import? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(other_user)
    end

    it "allows an admin to delete any user" do
      expect(subject).to permit(admin)
    end
  end
end
