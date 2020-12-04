class Account::OsbbsController < Account::AccountController
  def search
    @osbbs = Osbb.search(params[:term])
  end
end
