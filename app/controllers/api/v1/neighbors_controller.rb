class Api::V1::NeighborsController < Api::ApiController
  include ControllerHelper
  before_action :neighbor, only: :update

  def index
    @neighbors = current_user.neighbors
  end

  def update
    if @neighbor.update(neighbor_params)
      render json: @neighbor
    else
      render json: @neighbor.errors, status: :unprocessable_entity
    end
  end

  def search
    @neighbors = User.search(where: {
                               approved: params[:approved],
                               osbb_id: current_user.osbb_id,
                               id: { not: current_user.id }
                             })
  end

  private

  def neighbor_params
    params.require(:neighbor).permit(:osbb_id, :approved, :role)
  end

  def neighbor
    @neighbor ||= User.find(params[:id])
  end
end
