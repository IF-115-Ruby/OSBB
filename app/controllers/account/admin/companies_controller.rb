class Account::Admin::CompaniesController < Account::Admin::AdminController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @ransack = Company.ransack(params[:q])
    @companies = @ransack.result.page(params[:page]).per(12)
  end

  def new
    @company = Company.new
  end

  def show; end

  def create
    @company = Company.new(company_params)

    if @company.save
      flash[:success] = "Your company \"#{@company.name}\" - created with id:#{@company.id}"
      redirect_to [:account, :admin, @company]
    else
      flash.now[:warning] = 'Invalid company parameters!'
      render :new
    end
  end

  def edit; end

  def update
    if @company.update(company_params)
      flash[:success] = "Company profile \"#{@company.name}\"  updated"
      redirect_to [:account, :admin, @company]
    else
      render 'edit', warning: 'Invalid parameters for editing'
    end
  end

  def destroy
    @company.destroy
    redirect_to action: :index
    flash[:danger] = "Company profile \"#{@company.name}\" with id:#{@company.id} has been deleted"
  end

  private

  def company_params
    params.require(:company).permit(:name, :company_type, :phone, :email, :website, :fax)
  end

  def set_company
    @company = Company.find_by(id: params[:id])
  end
end
