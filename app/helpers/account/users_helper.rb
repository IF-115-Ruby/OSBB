module Account::UsersHelper
  def options_for_sex
    User::SEX_TYPES.map do |sex|
      [I18n.t("account.users.form.sex.#{sex}"), sex]
    end
  end
end
