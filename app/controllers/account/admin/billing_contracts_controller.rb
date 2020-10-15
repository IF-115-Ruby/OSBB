class Account::Admin::BillingContractsController < Account::Admin::AdminController
  include ControllerHelper
  before_action :set_billing_contract, only: %i[show update edit destroy]

  def index
    @billing_contracts = BillingContract.all
  end

  def new
    @billing_contract = BillingContract.new
  end

  def show; end

  def create
    @billing_contract = BillingContract.new(billing_contract_params)

    if @billing_contract.save
      flash[:success] = "Billing contract '#{@billing_contract.contract_num}' created."
      redirect_to [:account, :admin, @billing_contract]
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :new
    end
  end

  def edit; end

  def update
    if @billing_contract.update(billing_contract_params)
      successful_update("Billing contract '#{@billing_contract.contract_num}' updated.")
      redirect_to [:account, :admin, @billing_contract]
    else
      flash.now[:warning] = 'Invalid billing contract parameters!'
      render :edit
    end
  end

  def destroy
    @billing_contract.destroy

    redirect_to action: :index
    flash[:danger] = "Billing contract '#{@billing_contract.contract_num}' deleted."
  end

  private

  def billing_contract_params
    params.require(:billing_contract).permit(:contract_num, :is_active)
  end

  def set_billing_contract
    @billing_contract = BillingContract.find(params[:id])
  end
end
