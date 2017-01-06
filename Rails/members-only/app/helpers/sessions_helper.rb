module SessionsHelper

  # Checks if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Logs the user in
  def log_in(user)
    session[:user_id] = user.id
    remember(user)
    user.remember
    current_user
  end

  def log_out(user)
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Gives the user a new remember token
  def remember(user)
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  # Returns the current user
  def current_user
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
  end

end
