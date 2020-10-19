# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def admin_notification
    AdminMailer.admin_notification(User.first)
  end
end
