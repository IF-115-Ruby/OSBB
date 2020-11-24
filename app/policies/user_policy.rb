class UserPolicy < AdminPolicy
  %w[index? destroy?].each do |action|
    define_method(action) do
      user_admin
    end
  end

  def myosbb?
    %w[lead members].include?(@current_user.role)
  end
end
