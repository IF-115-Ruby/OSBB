class Api::V1::Account::Admin::OsbbsController < Account::Admin::AdminController
  def show
    render json: Osbb.find_by(id: params[:id])
  end
end
