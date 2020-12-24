class Account::Admin::CompaniesController < Account::Admin::AdminController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    authorize :company
    @ransack = Company.ransack(params[:q])
    @companies = @ransack.result.page(params[:page]).per(12)
  end

  def new
    authorize :company
    @company = Company.new
  end

  def show
    authorize @company
  end

  def create
    authorize :company
    @company = Company.new(company_params)

    if @company.save
      flash[:success] = "Your company \"#{@company.name}\" - created with id:#{@company.id}"
      redirect_to [:account, :admin, @company]
    else
      flash.now[:warning] = 'Invalid company parameters!'
      render :new
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(company_params)
      flash[:success] = "Company profile \"#{@company.name}\"  updated"
      redirect_to [:account, :admin, @company]
    else
      render 'edit', warning: 'Invalid parameters for editing'
    end
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to action: :index
    flash[:danger] = "Company profile \"#{@company.name}\" with id:#{@company.id} has been deleted"
  end

  def new_import
    authorize :company
    @companies_import = CompaniesImport.new

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def import
    authorize :company
    @companies_import = CompaniesImport.new(params[:companies_import])

    if @companies_import.perform
      redirect_to account_admin_companies_path, flash: { success: 'Companies were imported.' }
    else
      render :new_import
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :company_type, :phone, :email, :website, :fax, :payment_coefficient)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
