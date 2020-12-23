class Api::V1::CommentsController < Api::ApiController
  before_action :find_commentable, only: %i[create]
  before_action :for_delete, only: :destroy

  def index
    @news = News.find(params[:news_id])
    @comments = @news.comments.page params[:page]
    render 'api/v1/news/comments/index'
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    handle_response
  end

  def destroy
    @comment.destroy
    if params[:parent_comment] && params[:parent_comment] != params[:id]
      @response = News.find(params[:news_id]).comments.find(params[:parent_comment])
      render 'api/v1/news/comments/update.json'
    else
      render json: 'done'
    end
  end

  private

  def comment_params
    params.permit(:body)
  end

  def find_commentable
    @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
    @commentable = News.find(params[:news_id]) if params[:news_id]
  end

  def for_delete
    @comment = Comment.find(params[:id])
  end

  def handle_response
    if comment.commentable_type == 'News'
      render json: @comment
    else
      @response = News.find(params[:id_news]).comments.find(params[:comment_id])
      render 'api/v1/news/comments/update.json'
    end
  end
end
