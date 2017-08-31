class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @post = current_user.posts.build
    @feed_items = @user.feed.paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to :back, notice: 'Post unsuccessful!' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build(params[:post_id])
    @feed_items = @post.comments.paginate(page: params[:page])

  end

  def like
    @post = Post.find(params[:id])
    if post_liked
      @like.update(like: params[:like])
      redirect_to :back
    else
      Like.create(likeable: @post, user: current_user, like: params[:like])
      flash[:success] = "Like Counted!"
      redirect_to :back

      respond_to do |format|
        format.html do
          flash[:success] = "Like Counted!"
          redirect_to :back
        end
        format.js do
        end
      end
    end
  end


  private

  def post_liked
    liked?(@post)
  end

  def liked?(type)
    @like = Like.find_by(likeable: type, user: current_user)
  end

  def post_params
    params.require(:post).permit(:title, :content, :picture)
  end

end
