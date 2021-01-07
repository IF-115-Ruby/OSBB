class Api::V1::CommentsController < Api::ApiController
  before_action :find_commentable, only: %i[create]
  before_action :for_delete, only: :destroy
  before_action :find_news

  def index
    @comments = @news.comments.page params[:page]
    render 'api/v1/news/comments/index'
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save && send_to_broadcast(@news.comments.page(params[:page]))
  end

  def destroy
    @comment.destroy && send_to_broadcast(@news.comments.page(params[:page]))
  end

  private

  def comment_params
    params.permit(:body)
  end

  def find_commentable
    @commentable = News.find(params[:news_id]) if params[:news_id]
    @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
  end

  def for_delete
    @comment = Comment.find(params[:id])
  end

  def send_to_broadcast(page)
    @comments = page
    NewsChannel.broadcast_to(@news, render('api/v1/news/comments/index'))
  end

  def find_news
    @news = News.find(params[:news_id])
  end
end
