class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params)
    respond_to do |format|
      format.html
      format.json { render :json => post, comment }
    end
  end

  def upvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.increment!(:upvotes)

    respond_to do |format|
      format.html
      format.json { render :json => post, comment }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
