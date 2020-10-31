class Account::Admin::PaymentsImportsController < Account::Admin::AdminController
  def new
    @payments_import = PaymentsImport.new
  end

  def create
    @payments_import = PaymentsImport.new(params[:payments_import])
    if @payments_import.save
      flash[:success] = "Payments were imported."
      redirect_to account_admin_companies_path
    else
      render :new
    end
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to new_account_admin_payments_import_path
  end
end
