class Api::V1::NewsController < ApplicationController
  def index
    @news = current_user.osbb.news.page params[:page]
  end
end
