class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    @user = User.find(params[:user_id])
  end

  def show
    redirect_to user_path(params[:id])
  end

  def new
    @user = current_user
    @friend = User.new
  end

  def create
    @user = current_user
    @friend = User.find(params[:friend_id])
    friendship1hash = { :user_id => @user.id, :friend_id => @friend.id, :status => 'requested' }
    friendship2hash = { :user_id => @friend.id, :friend_id => @user.id, :status => 'pending' }
    @friendship1 = Friendship.create(friendship1hash)
    @friendship2 = Friendship.create(friendship2hash)
    if @friendship1.save && @friendship2.save
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_friends_path(current_user)
    end
  end

  def update
    @user = User.find(current_user.id)
    @friend = User.find(params[:id])
    friendship1hash = { :user_id => @user.id, :friend_id => @friend.id, :status => 'accepted' }
    friendship2hash = { :user_id => @friend.id, :friend_id => @user.id, :status => 'accepted' }
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    if @friendship1.update(friendship1hash) && @friendship2.update(friendship2hash)
      flash[:success] = 'Friend accepted!'
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @friend = User.find(params[:id])
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    if @friendship1.destroy && @friendship2.destroy
      flash[:alert] = 'Connection Eliminated'
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  private
  def friend_params
    params.require(:user_id)
  end

end
