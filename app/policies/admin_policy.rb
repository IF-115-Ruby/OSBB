class AdminPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user

    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user == @user
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    @current_user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    return false if @current_user == @user

    @current_user.admin?
  end
end
