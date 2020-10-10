class Account::UtilityProvidersController < Account::AccountController
  before_action :set_company, only: %i[new update]
  before_action :set_billing_contract, only: :update

  def index
    @utility_providers = current_user.billing_contracts.page params[:page]
  end

  def search
    @q = Company.joins(:account).ransack(params[:q])
    @companies = @q.result.page(params[:page]).per(6)
    render :companies
  end

  def new
    if !current_user.companies.find_by(id: @company.id)
      @billing_contract = BillingContract.new
    else
      flash[:warning] = 'Contract was associated with another user!'
      redirect_to %i[account utility_providers]
    end
  end

  def update
    if @billing_contract&.user_id.nil? && @billing_contract&.update(user_id: current_user.id)
      flash[:success] = "Billing contract updated."
      redirect_to %i[account utility_providers]
    else
      flash.now[:warning] = 'Wrong billing contract number!'
      @billing_contract ||= BillingContract.new
      render :new
    end
  end

  def disassociate
    @billing_contract = current_user.billing_contracts.find_by(id: params[:id])

    if @billing_contract.update(user_id: nil)
      flash[:success] = "Billing contract was removed."
    else
      flash.now[:warning] = 'Something went wrong.'
    end
    redirect_to %i[account utility_providers]
  end

  private

  def utility_provider_params
    params.require(:billing_contract).permit(:contract_num, :company_id)
  end

  def set_billing_contract
    @billing_contract = Company.find_by(
      id: utility_provider_params[:company_id]
    ).billing_contracts.find_by(
      contract_num: utility_provider_params[:contract_num]
    )
  end

  def set_company
    @company = Company.find_by(id: utility_provider_params[:company_id])
  end
end
