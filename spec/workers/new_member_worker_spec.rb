require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe NewMemberWorker, type: :worker do
  let!(:osbb) { create(:osbb) }
  let!(:valid_user) { create(:user) }

  describe '#perform' do
    before do
      allow(UserMailer).to receive(:send_assign_notification).with(:deliver_now)
    end

    it 'not calls UserMailer if user id not exist' do
      described_class.new.perform(osbb.id * 0, valid_user.id * 0)

      expect(UserMailer).not_to have_received(:send_assign_notification).with(valid_user)
    end

    it 'add new job' do
      expect do
        described_class.perform_async(osbb_id: osbb.id, id: valid_user.id)
      end.to change(described_class.jobs, :size).by(1)
    end

    it 'do new job' do
      valid_user.update(osbb_id: osbb.id, role: :members)
      expect(described_class.perform_async(osbb.id, valid_user.id)).to be_truthy
    end
  end
end
