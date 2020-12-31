class Api::V1::PostsController < Api::ApiController
  before_action :set_post_by_role
  before_action :set_post, only: %i[show update destroy]

  def index
    authorize :post
    @posts = current_user.osbb.posts.order(id: :desc)
  end

  def show; end

  def create
    authorize :post
    @post = current_user.posts.build(post_params)
    @post.osbb_id = current_user.osbb_id
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: :show, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy if @post.present?
  end

  private

  def post_params
    params.permit(:title, :short_description, :long_description, :image, :is_visible, :is_private, :osbb_id, :user_id)
  end

  def set_post_by_role
    @post = if current_user.lead?
              Post.where(osbb_id: current_user.osbb_id)
            else
              Post.where(osbb_id: current_user.osbb_id).visible
            end.ordered
  end

  def set_post
    @post = Post.find(params[:id])
    authorize @post
  end
end
