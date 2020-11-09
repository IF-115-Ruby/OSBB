require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SignUpEmailSenderWorker, type: :worker do
  let!(:valid_user) { FactoryBot.build(:user) }

  it 'add new job' do
    expect { described_class.perform_async(1) }.to change(described_class.jobs, :size).by(1)
  end

  it 'do new job' do
    valid_user.save
    expect(subject.perform(valid_user.id)).to be_truthy
  end
end
