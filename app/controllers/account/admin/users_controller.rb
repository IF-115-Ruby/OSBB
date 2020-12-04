class Account::Admin::UsersController < Account::Admin::AdminController
  include ControllerHelper
  before_action :user, only: :destroy

  def index
    authorize :user
    @users = User.page params[:page]
  end

  def destroy
    authorize @user
    @user.destroy
    flash[:danger] = 'User profile has been deleted'
  end

  private

  def user
    @user ||= User.find_by(id: params[:id])
  end
end
