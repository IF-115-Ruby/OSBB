require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "notify" do
    let(:user) { FactoryBot.create(:user, role: 0) }
    let(:mail) { AdminMailer.admin_notification(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("New user was registered!")
      expect(mail.to).to eq(User.admin.pluck(:email))
      expect(mail.from).to eq(["frankivsk.osbb@gmail.com"])
    end
  end
end
