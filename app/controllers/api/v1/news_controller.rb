class Api::V1::NewsController < Api::ApiController
  before_action :set_news_by_role
  before_action :set_post, only: %i[show update destroy]
  def index
    authorize :news
    @news = current_user.osbb.news.page params[:page]
  end

  def show; end

  def update
    authorize :news
    if @post
      @post.update(post_params)
      render json: @post
    end
  end

  def create
    authorize :news
    @post = current_user.news.build(post_params)
    @post.osbb_id = current_user.osbb_id
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def destroy
    News.destroy(params[:id])
  end

  private

  def post_params
    params.permit(:id, :title, :short_description, :long_description, :image, :is_visible)
  end

  def set_news_by_role
    @news = if current_user.lead?
              News.where(osbb_id: current_user.osbb_id)
            else
              News.where(osbb_id: current_user.osbb_id).visible
            end.ordered
  end

  def set_post
    @post = @news.find(params[:id])
    authorize @post
  end
end
