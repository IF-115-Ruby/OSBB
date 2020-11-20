class Api::V1::Account::Admin::OsbbsController < ApplicationController
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder

  def show
    @osbb = Osbb.find_by(id: params[:id])
  end
end
