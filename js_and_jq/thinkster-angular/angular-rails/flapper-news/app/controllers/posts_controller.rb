class PostsController < ApplicationController

  def index
    posts = Post.all
    respond_to do |format|
      format.html
      format.json { render :json => posts }
    end
  end

  def create
    post = Post.create(post_params)

    respond_to do |format|
      format.html
      format.json { render :json => post }
    end
  end

  def show
    post = Post.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => post }
    end
  end

  def upvote
    post = Post.find(params[:id])
    post.increment!(:upvotes)

    respond_to do |format|
      format.html
      format.json { render :json => post }
    end
  end

  private
  def post_params
    params.require(:post).permit(:link, :title)
  end

end
