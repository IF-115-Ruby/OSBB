class AdminPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user

    @current_user = current_user
    @model = model
  end

  def start_impersonate?
    user_admin
  end

  def stop_impersonating?
    model.admin?
  end

  private

  def user_admin
    @current_user.admin?
  end
end
