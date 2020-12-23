class Account::UsersController < Account::AccountController
  include ControllerHelper
  before_action :user, only: %i[show edit update]

  def show; end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      successful_update("User profile \"#{@user.full_name}\"  updated")
      redirect_to edit_account_user_path(@user)
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def myosbb
    authorize :user
  end

  def posts
    authorize :user
  end

  def new_assign_osbb
    @user = authorize current_user
  end

  def assign_osbb # rubocop:disable Metrics/AbcSize
    @user = current_user
    osbb = Osbb.find_by(name: user_osbb_params[:osbb_id])
    if osbb && current_user.update(osbb_id: osbb.id, role: :member)
      NewMemberWorker.perform_async(osbb.id, current_user.id)
      flash[:success] = "Congratulations, You have become a member of #{osbb.name} OSBB"
      redirect_to account_admin_osbb_path(current_user.osbb)
    else
      flash.now[:warning] = 'You have to choose the existing OSBB!'
      render :new_assign_osbb
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name,
      :email, :avatar,
      :birthday, :mobile,
      :role, :sex,
      :password,
      address_attributes: %i[city country state street]
    )
  end

  def user_osbb_params
    params.require(:user).permit(:osbb_id)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
