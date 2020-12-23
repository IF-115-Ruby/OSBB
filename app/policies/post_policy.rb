class PostPolicy < BasePolicy
  %w[index? show? create? update? destroy?].each do |action|
    define_method(action) do
      not_simple_user?
    end
  end

  private

  def not_simple_user?
    %w[admin lead member].include?(current_user.role)
  end
end
