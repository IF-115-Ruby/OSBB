class UserPolicy < AdminPolicy
  def index?
    user_admin_or_lead?
  end

  def new_assign_osbb?
    user_simple_or_admin?
  end

  def assign_osbb?
    user_simple?
  end

  def destroy?
    user_admin?
  end

  def myosbb?
    %w[lead member].include?(@current_user.role)
  end
end
