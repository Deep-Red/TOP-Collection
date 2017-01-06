class PostsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    redirect_to posts_path if @post.save
  end

  def index
    @posts = Post.all.paginate(page: params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end


    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

end
