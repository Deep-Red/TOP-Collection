class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to root_path
  end

  def show
    @user = current_user
    @events = @user.events
    @invitations = @user.invitations

    @upcoming_events = @user.upcoming_events(@invitations)
    @prev_events = @user.prev_events(@invitations)
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
