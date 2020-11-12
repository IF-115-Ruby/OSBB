class OsbbPolicy < AdminPolicy
  ["index?", "show?", "create?", "new?", "update?", "edit?", "destroy?"].each do |action|
    define_method(action) do
      user_admin
    end
  end
end
