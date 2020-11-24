# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def send_assign_notification
    lead = User.lead.find_by(osbb_id: 20)
    user = User.simple.first
    UserMailer.send_assign_notification(lead, user)
  end
end
