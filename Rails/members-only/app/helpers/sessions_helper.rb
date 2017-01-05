module SessionsHelper

  # Checks if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Logs the user in
  def log_in(user)
    session[:user_id] = user.id
  end

  # Gives the user a new remember token
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the current user
  def current_user
    user = User.find_by(id: cookies.signed[:user_id])
    if user && user.authenticate(cookies[:remember_token])
      log_in user
    end
  end
end
