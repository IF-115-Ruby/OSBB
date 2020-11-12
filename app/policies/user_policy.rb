class UserPolicy < AdminPolicy
  def index?
    user_admin
  end

  def destroy?
    user_admin
  end
end
