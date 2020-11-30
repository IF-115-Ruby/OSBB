class Api::V1::NewsController < Api::ApiController
  def index
    @news = current_user.osbb.news.page params[:page]
  end

  def show
    @post = News.find(params[:id])
    authorize @post
  end
end
