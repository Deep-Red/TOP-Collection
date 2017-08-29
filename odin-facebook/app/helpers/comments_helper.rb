module CommentsHelper
  def upvotes(comment)
    return comment.likes.where(like: [true]).size
  end

  def liked(type)
    @like = Like.find_by(likeable: type, user: current_user)
    if @like
      return @like.like
    else
      return false
    end
  end

end
