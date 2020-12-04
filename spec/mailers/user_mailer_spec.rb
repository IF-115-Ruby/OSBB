require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "notify" do
    let!(:user) { create(:user, role: :member) }
    let!(:lead) { create(:user, role: :lead) }
    let!(:mail) { described_class.send_assign_notification(lead, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("#{user.full_name} joined your OSBB")
      expect(mail.to).to eq(User.lead.pluck(:email))
      expect(mail.from).to eq(["frankivsk.osbb@gmail.com"])
    end

    it "contains link to user" do
      expect(mail.body.encoded).to match(account_user_url(user).to_s)
    end
  end
end
