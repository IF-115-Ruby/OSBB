require 'rails_helper'

RSpec.describe NewsChannel, type: :channel do
  let!(:osbb) { create(:osbb) }
  let!(:lead) { create(:user, osbb: osbb, role: :lead) }
  let!(:news) { create(:news, user: lead, osbb: osbb) }

  it "successfully subscribes" do
    subscribe news_id: news.id
    expect(subscription).to be_confirmed
  end
end
