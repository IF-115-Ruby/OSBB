class Api::V1::NewsController < Api::ApiController
  def index
    @news = current_user.osbb.news.page params[:page]
  end
end
