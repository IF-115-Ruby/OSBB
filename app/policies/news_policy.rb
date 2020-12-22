class NewsPolicy < BasePolicy
  %i[index? show?].each do |method|
    define_method(method) { user_admin_or_member? }
  end

  %i[create? new? edit? update? destroy?].each do |method|
    define_method(method) { user_admin_or_lead? }
  end

  private

  def user_admin_or_lead?
    %w[admin lead].include?(current_user.role)
  end

  def user_admin_or_member?
    user_admin_or_lead? || current_user.member?
  end
end