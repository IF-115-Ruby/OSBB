class NewMemberWorker
  include Sidekiq::Worker

  def perform(osbb_id, current_user_id)
    lead = User.lead.find_by(osbb_id: osbb_id)
    user = User.find_by(id: current_user_id)
    return unless lead

    UserMailer.send_assign_notification(lead, user).deliver_now
  end
end
