class BasePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless current_user

    @current_user = current_user
    @user = model
  end
end
