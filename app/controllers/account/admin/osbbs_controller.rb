class Account::Admin::OsbbsController < Account::Admin::AdminController
  include ControllerHelper
  before_action :osbb, only: %i[show edit update destroy]

  def index
    authorize :osbb
    @osbbs = Osbb.page(params[:page]).per(9)
  end

  def show; end

  def new
    authorize :osbb
    @osbb = Osbb.new
  end

  def create # rubocop:disable Metrics/AbcSize
    @osbb = authorize Osbb.new(osbb_params)
    if @osbb.save
      successful_update("Osbb profile '#{@osbb.name}' - created with id:#{@osbb.id}")
      current_user.update(osbb_id: @osbb.id, role: :lead) unless current_user.admin?
      redirect_to [:account, :admin, @osbb]
    else
      flash.now[:warning] = 'Invalid OSBB parameters'
      render :new
    end
  end

  def edit
    authorize @osbb
  end

  def update
    authorize @osbb
    if @osbb.update(osbb_params)
      flash[:success] = "Osbb profile \"#{@osbb.name}\"  updated"
      redirect_to [:account, :admin, @osbb]
    else
      flash.now[:warning] = 'Invalid parameters for editing'
      render :edit
    end
  end

  def destroy
    authorize @osbb
    @osbb.destroy
    redirect_to account_admin_osbbs_path
    flash[:danger] = "Osbb profile \"#{@osbb.name}\" with id:#{@osbb.id} has been deleted"
  end

  private

  def osbb_params
    params.require(:osbb).permit(
      :name,
      :phone,
      :email,
      :website,
      :is_available
    )
  end

  def osbb
    @osbb ||= Osbb.find(params[:id])
  end
end
