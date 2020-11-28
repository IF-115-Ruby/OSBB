class OsbbPolicy < AdminPolicy
  %w[index? update? edit? destroy? new_import? import?].each do |action|
    define_method(action) do
      user_admin?
    end
  end

  def new?
    user_simple_or_admin?
  end

  def edit?
    user_simple_or_admin?
  end

  def show?
    user_admin_or_member?
  end

  def create?
    user_simple_or_admin?
  end
end
