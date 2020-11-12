class Account::Admin::BillingContractsController < Account::Admin::AdminController
  include ControllerHelper
  before_action :set_company
  before_action :set_billing_contract, only: %i[show edit update destroy]

  def index
    authorize :billing_contract
    @billing_contracts = @company.billing_contracts.all
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=billing-contracts.xlsx"
      end
      format.csv { send_data @billing_contracts.to_csv }
      format.html { @billing_contracts = @company.billing_contracts.page params[:page] }
    end
  end

  def new
    authorize :billing_contract
    @billing_contract = @company.billing_contracts.build
  end

  def show
    authorize @billing_contract
  end

  def create
    authorize :billing_contract
    @billing_contract = @company.billing_contracts.build(billing_contract_params)

    if @billing_contract.save
      flash[:success] = "Billing contract '#{@billing_contract.contract_num}' created."
      redirect_to account_admin_company_billing_contract_path(@company, @billing_contract)
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :new
    end
  end

  def edit
    authorize @billing_contract
  end

  def update
    authorize @billing_contract
    if @billing_contract.update(billing_contract_params)
      successful_update("Billing contract '#{@billing_contract.contract_num}' updated.")
      redirect_to account_admin_company_billing_contract_path(@company, @billing_contract)
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :edit
    end
  end

  def destroy
    authorize @billing_contract
    @billing_contract.destroy

    redirect_to account_admin_company_billing_contracts_path(@company)
    flash[:danger] = "Billing contract '#{@billing_contract.contract_num}' deleted."
  end

  def new_import
    authorize :billing_contract
    @billing_contracts_import = BillingContractsImport.new
    respond_to do |format|
      format.xlsx do
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=billing-contracts-template.xlsx"
      end

      format.html { render :new_import }
    end
  end

  def import
    authorize :billing_contract
    @billing_contracts_import = BillingContractsImport.new(params[:billing_contracts_import])

    if @billing_contracts_import.perform
      redirect_to account_admin_company_billing_contracts_path, success: 'Billing contracts was successfully uploaded'
    else
      render :new_import
    end
  end

  private

  def billing_contract_params
    params.require(:billing_contract).permit(:contract_num, :is_active, :company_id)
  end

  def set_billing_contract
    @billing_contract = @company.billing_contracts.find_by(id: params[:id])
  end

  def set_company
    @company = Company.find_by(id: params[:company_id])
  end
end
