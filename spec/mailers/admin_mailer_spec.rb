require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "notify" do
    let!(:user) { FactoryBot.create(:user, role: :admin) }
    let!(:mail) { described_class.admin_notification(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("New user was registered!")
      expect(mail.to).to eq(User.admin.pluck(:email))
      expect(mail.from).to eq(["frankivsk.osbb@gmail.com"])
    end

    it "contains link to user" do
      expect(mail.body.encoded).to match(account_user_url(user).to_s)
    end
  end
end
