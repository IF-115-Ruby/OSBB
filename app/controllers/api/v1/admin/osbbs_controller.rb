class Api::V1::Admin::OsbbsController < ApplicationController
  def show
    @osbb = Osbb.find_by(id: params[:id])
  end
end
