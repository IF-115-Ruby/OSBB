require 'rails_helper'

RSpec.describe PaymentPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }

  permissions :new_import?, :import? do
    it 'prevents deleting yourself' do
      expect(subject).to permit(admin)
    end
  end
end
