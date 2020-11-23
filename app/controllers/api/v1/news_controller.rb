class Api::V1::NewsController < Api::ApiController
  include Pundit
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_news_by_role
  before_action :set_post, only: %i[show edit update destroy]

  def index
    authorize :news
    @news = @news.page params[:page]
    render json: @news
  end

  def show; end

  def new
    authorize :news
    @post = News.new
    render json: @post
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

  def edit; end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors
    end
  end

  def destroy
    @post.destroy if @post.present?
    render json: @post
  end

  private

  def post_params
    params.require(:news).permit(:title, :short_description, :long_description, :image, :is_visible)
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

  def not_found
    render "errors/not_found", layout: 'errors'
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || home_path)
  end
end
