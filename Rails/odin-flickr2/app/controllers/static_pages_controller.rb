class StaticPagesController < ApplicationController
  def index
    @user_id = params[:flickr_id]
  end
end
