class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user
#      puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
      # Log the user in and redirect to the user's show page
      log_in session
#      puts "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
#      puts user.name
      redirect_to user
    else
      flash.now[:danger] = 'Invalid user'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
#  def session_params
#    require(:session).permit(:name.downcase)
#  end
end
