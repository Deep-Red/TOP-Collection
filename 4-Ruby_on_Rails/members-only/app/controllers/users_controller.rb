class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def show
    @user = current_user
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
