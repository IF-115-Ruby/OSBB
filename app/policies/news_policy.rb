class NewsPolicy < BasePolicy
  def index?
    user_admin_or_member?
  end

  def show?
    user_admin_or_member?
  end

  def create?
    user_admin_or_lead?
  end

  def new?
    user_admin_or_lead?
  end

  def edit?
    user_admin_or_lead?
  end

  def update?
    user_admin_or_lead?
  end

  def destroy?
    user_admin_or_lead?
  end

  private

  def user_admin_or_lead?
    %w[admin lead].include?(current_user.role)
  end

  def user_admin_or_member?
    user_admin_or_lead? || current_user.members?
  end
end
