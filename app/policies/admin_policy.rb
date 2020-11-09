class AdminPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user

    @current_user = current_user
    @user = model
  end

  def user_admin
    @current_user.admin?
  end

  def index?
    user_admin
  end

  def show?
    index? || @current_user == @user
  end

  def create?
    index? || @current_user == @user
  end

  def new?
    create?
  end

  def update?
    user_admin
  end

  def edit?
    update?
  end

  def destroy?
    return false if @current_user == @user

    user_admin
  end
end
