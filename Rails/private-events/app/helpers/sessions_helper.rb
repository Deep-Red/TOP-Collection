module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    cookies.permanent.signed[:user_id] = user.id
    @user = current_user
  end

  # Logs out the given user.
  def log_out
    cookies.delete(:user_id)
  end

  def current_user
    user_id = cookies.signed[:user_id]
    user = User.find_by(id: user_id)
  end

end
