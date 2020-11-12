class Account::NewsController < Account::AccountController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_news_by_role
  before_action :set_post, only: %i[show edit update]

  def index; end

  def show; end

  def new
    @post = News.new
  end

  def create
    @post = current_user.news.build(post_params)
    @post.osbb_id = current_user.osbb_id
    authorize @post
    if @post.save
      redirect_to account_news_index_path
      flash[:success] = "News \"#{@post.title}\" with id:#{@post.id} has been succesfully created!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to account_news_path(@post)
      flash[:success] = "News \"#{@post.title}\" with id:#{@post.id} has been edited"
    else
      render :edit
    end
  end

  def destroy
    @post = News.find(params[:id])
    authorize @post
    @post.destroy if @post.present?
    redirect_to account_news_index_path
    flash[:danger] = "News \"#{@post.title}\" with id:#{@post.id} has been deleted"
  end

  private

  def post_params
    params.require(:news).permit(:title, :short_description, :long_description, :image, :is_visible)
  end

  def set_news_by_role
    @news = News.where(osbb_id: current_user.osbb_id, is_visible: true).order('created_at DESC').page params[:page]
    visible_check
    authorize @news
  end

  def set_post
    @post = @news.find(params[:id])
    authorize @post
  end

  def not_found
    render "errors/not_found", layout: 'errors'
  end

  def visible_check
    if current_user.admin? || current_user.lead?
      @news = News.where(osbb_id: current_user.osbb_id).order('created_at DESC').page params[:page]
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || home_path)
  end
end
