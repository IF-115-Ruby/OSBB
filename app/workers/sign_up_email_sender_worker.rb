class SignUpEmailSenderWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    AdminMailer.admin_notification(user).deliver_now
    UserMailer.send_welcome_email(user).deliver_now
  end
end
