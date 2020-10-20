class AdminMailer < ApplicationMailer
  def admin_notification(user)
    @user = user

    mail(
      to: User.admin.pluck(:email),
      subject: t('devise.mailer.admin_notification.subject')
    )
  end
end
