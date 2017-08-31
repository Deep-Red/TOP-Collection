class LikesController < ApplicationController
#  def create
#    @likeable = find_likeable
#    @like = current_user.likes.build(likeable: @likeable)
#
#    if @like.save
#      redirect_to user_path(current_user), notice: "Liked!"
#    else
#      redirect_to user_path(current_user), notice: "Error!"
#    end
#  end
#
#  private
#
#  def find_likeable
#    params.each do |name, value|
#      if name =~ /(.+)_id$/
#        return $1.classify.constantize.find(value)
#      end
#    end
#    nil
#  end
end
