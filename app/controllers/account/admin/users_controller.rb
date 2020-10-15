class Account::Admin::UsersController < Account::Admin::AdminController
  include ControllerHelper
  before_action :user, only: :destroy

  def index
    @users = User.page params[:page]
  end

  def destroy
    @user.destroy
    redirect_to %i[account admin users]
    flash[:danger] = 'User profile has been deleted'
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
