class Account::Admin::PaymentsController < Account::Admin::AdminController
  def new_import
    @payments_import = PaymentsImport.new

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def import
    @payments_import = PaymentsImport.new(params[:payments_import])

    if @payments_import.perform
      redirect_to account_admin_companies_path, flash: { success: 'Payments were imported.' }
    else
      render :new_import
    end
  end
end
