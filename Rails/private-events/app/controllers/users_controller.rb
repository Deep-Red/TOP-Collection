class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to user_path
  end

  def show
    @user = User.find()
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end
end
