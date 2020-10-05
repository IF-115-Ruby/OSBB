class UsersController < ApplicationController
  include ControllerHelper
  before_action :user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def destroy
    @user.destroy
    redirect_to [:users]
    flash[:danger] = "User profile has been deleted"
  end

  def update
    if @user.update(user_params)
      successful_update("User profile \"#{@user.full_name}\"  updated")
      redirect_to @user
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :avatar, :birthday, :mobile, :role, :sex, :password)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
