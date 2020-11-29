class AdminPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user

    @current_user = current_user
    @model = model
  end

  def start_impersonate?
    user_admin?
  end

  def stop_impersonating?
    model.admin?
  end

  private

  def user_admin?
    @current_user.admin?
  end

  def user_admin_or_lead?
    %w[admin lead].include?(current_user.role)
  end

  def user_admin_or_member?
    user_admin_or_lead? || current_user.member?
  end

  def user_simple?
    @current_user.simple?
  end

  def user_simple_or_admin?
    user_simple? || user_admin?
  end
end
