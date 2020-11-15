class Account::UtilityProvidersController < Account::AccountController
  before_action :set_company, only: :new
  before_action :set_billing_contract, only: :update

  def index
    @utility_providers = current_user.billing_contracts.page params[:page]
  end

  def show
    @utility_provider = current_user.billing_contracts.find(params[:id])
  end

  def search
    @q = Company.joins(:account).ransack(params[:q])
    @companies = @q.result(distinct: true).page(params[:page]).per(6)
    render :companies
  end

  def new
    if current_user.companies.find_by(id: @company.id)
      flash[:warning] = 'Company was associated with you!'
      redirect_to %i[account utility_providers]
    else
      @billing_contract = @company.billing_contracts.build
    end
  end

  def update
    if @billing_contract&.update(user_id: current_user.id)
      flash[:success] = 'Billing contract updated.'
      redirect_to %i[account utility_providers]
    else
      flash.now[:warning] = 'Wrong billing contract number!'
      @billing_contract = @company.billing_contracts.build
      render :new
    end
  end

  def disassociate
    @billing_contract = current_user.billing_contracts.find(params[:id])

    @billing_contract.update(user_id: nil)
    flash[:success] = 'Billing contract was removed.'
    redirect_to %i[account utility_providers]
  end

  private

  def utility_provider_params
    params.require(:billing_contract).permit(:contract_num)
  end

  def set_billing_contract
    @billing_contract = set_company.billing_contracts.find_by(
      contract_num: utility_provider_params[:contract_num],
      user_id: nil
    )
  end

  def set_company
    @company = Company.find_by(id: params[:company_id])
  end
end
