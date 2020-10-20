class Account::Admin::AdminController < Account::AccountController
  def start_impersonate
    user = User.non_admin.find_by(id: params[:user_id])
    if user.present?
      impersonate_user(user)
      redirect_to home_path
    else
      flash.now[:danger] = 'You can\'t impersonate this user'
      redirect_to account_admin_users_path
    end
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to account_admin_users_path
  end
end
