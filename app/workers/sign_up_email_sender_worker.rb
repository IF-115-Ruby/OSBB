class SignUpEmailSenderWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    AdminMailer.admin_notification(user).deliver_now
    UserMailer.send_welcome_email(user).deliver_now
  end
end
