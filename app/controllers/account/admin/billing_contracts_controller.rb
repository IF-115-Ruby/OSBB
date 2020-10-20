class Account::Admin::BillingContractsController < Account::Admin::AdminController
  include ControllerHelper
  before_action :set_company
  before_action :set_billing_contract, only: %i[show edit update destroy]

  def index
    @billing_contracts = @company.billing_contracts.page params[:page]
  end

  def new
    @billing_contract = @company.billing_contracts.build
  end

  def show; end

  def create
    @billing_contract = @company.billing_contracts.build(billing_contract_params)

    if @billing_contract.save
      flash[:success] = "Billing contract '#{@billing_contract.contract_num}' created."
      redirect_to account_admin_company_billing_contract_path(@company, @billing_contract)
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :new
    end
  end

  def edit; end

  def update
    if @billing_contract.update(billing_contract_params)
      successful_update("Billing contract '#{@billing_contract.contract_num}' updated.")
      redirect_to account_admin_company_billing_contract_path(@company, @billing_contract)
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :edit
    end
  end

  def destroy
    @billing_contract.destroy

    redirect_to account_admin_company_billing_contracts_path(@company)
    flash[:danger] = "Billing contract '#{@billing_contract.contract_num}' deleted."
  end

  private

  def billing_contract_params
    params.require(:billing_contract).permit(:contract_num, :is_active)
  end

  def set_billing_contract
    @billing_contract = @company.billing_contracts.find_by(id: params[:id])
  end

  def set_company
    @company = Company.find_by(id: params[:company_id])
  end
end
