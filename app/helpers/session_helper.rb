module SessionHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Play the given category
  def play_category(category)
    session[:category_id] = category.id
  end

  # Returns the current played category (if any)
  def current_category
    @current_category ||= Category.find_by(id: session[:category_id])
  end

  # Returns true if user is playing a game.
  def playing?
    !current_category.nil?
  end

  # End the current game
  def end_playing
    session.delete(:category_id)
    @current_category = nil
  end
end
