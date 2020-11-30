class Api::V1::UsersController < Api::ApiController
  def show
    @user = User.find(params[:id])
  end
end
