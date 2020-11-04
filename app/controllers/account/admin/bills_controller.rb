class Account::Admin::BillsController < Account::Admin::AdminController
  def new_import
    @bills_import = BillsImport.new

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def import
    @bills_import = BillsImport.new(params[:bills_import])

    if @bills_import.perform
      redirect_to account_admin_companies_path, flash: { success: 'Bills were imported.' }
    else
      render :new_import
    end
  end
end
