class OsbbsController < ApplicationController
  def index
    @osbbs = Osbb.page(params[:page]).per(12)
  end

  def show
    @osbb = Osbb.find_by(id: params[:id])
  end
end
