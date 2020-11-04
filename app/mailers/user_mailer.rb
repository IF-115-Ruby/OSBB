class UserMailer < ApplicationMailer
  def send_welcome_email(user)
    @user = user
    attachments.inline['if-mailer.png'] = File.read("#{Rails.root}/app/assets/images/if-mailer.png")

    mail(
      to: user.email,
      subject: t('user_mailer.welcome_email.welcome_title')
    )
  end
end
