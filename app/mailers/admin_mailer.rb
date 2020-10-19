class AdminMailer < ApplicationMailer
  def admin_notification(user)
    @user = user
    mail(to: User.admin.pluck(:email), subject: "New user was registered!")
  end
end
