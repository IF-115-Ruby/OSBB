class Account::Admin::AdminController < Account::AccountController
  before_action :authenticate_user!
  before_action :check_policy, except: :stop_impersonating

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
    authorize true_user
    stop_impersonating_user
    redirect_to account_admin_users_path
  end

  private

  def check_policy
    authorize current_user
  end
end
