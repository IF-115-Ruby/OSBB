class SearchOsbbsController < ApplicationController
  def search
    @osbbs = Osbb.search(params[:term])
  end
end
