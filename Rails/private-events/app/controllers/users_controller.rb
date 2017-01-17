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
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
