class OsbbPolicy < AdminPolicy
  def index?
    user_admin
  end

  def show?
    user_admin
  end

  def create?
    user_admin
  end

  def new?
    user_admin
  end

  def update?
    user_admin
  end

  def edit?
    user_admin
  end

  def destroy?
    user_admin
  end
end
