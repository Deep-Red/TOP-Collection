class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user
      # Log the user in and redirect to the user's show page
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid user'
      render 'new'
    end
  end

  def destroy
  end

  private
#  def session_params
#    require(:session).permit(:name.downcase)
#  end
end
