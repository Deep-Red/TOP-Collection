class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def index
    @comments = @post.comments.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comment = Comment.find(params[:comment_id])
  end

  def like
    @comment = Comment.find(params[:post_id])
    if comment_liked
      @like.update(like: params[:like])
      redirect_to :back
    else
      @like = current_user.likes.build(likeable: @comment, like: params[:like])
      puts @like.inspect
      @like.save
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

  def comment_liked
    liked?(@comment)
  end

  def liked?(comment)
    @like = Like.find_by(likeable: comment, likeable_id: comment)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
