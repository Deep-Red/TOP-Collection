module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    cookies.signed[:user_id] = User.find_by(name: params[:session][:name]).id
    @user = current_user
  end

  # Logs out the given user.
  def log_out
    cookies.delete(:user_id)
  end

  def current_user
    @current_user = User.find_by(id: cookies.signed[:user_id])
  end

end
