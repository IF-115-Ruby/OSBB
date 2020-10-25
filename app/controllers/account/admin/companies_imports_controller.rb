class Account::Admin::CompaniesImportsController < Account::Admin::AdminController
  def new
    @companies_import = CompaniesImport.new
  end

  def create
    if params.key?(:companies_import)
      @companies_import = CompaniesImport.new(params[:companies_import])
      if @companies_import.save
        redirect_to account_admin_companies_path, flash: { success: 'Companies were imported.' }
      else
        render :new
      end
    else
      redirect_to new_account_admin_companies_import_path, flash: { danger: 'Field can not be empty!' }
    end
  end
end
