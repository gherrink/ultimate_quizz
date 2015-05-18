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
    end_question
    session.delete(:category_id)
    @current_category = nil
  end

  # Play the given question
  def ask(question)
    session[:question_id] = question.id
    session[:correct_answer] = question.answer_correct
    session[:current_answers] = [@question.answer_correct, @question.answer_wrong_1, @question.answer_wrong_2, @question.answer_wrong_3].shuffle
  end

  def current_answer
    @current_answer ||= session[:correct_answer]
  end

  def current_answers
    @current_answers ||= session[:current_answers]
  end

  def current_question
    @current_question ||= Question.find_by(id: session[:question_id])
  end

  def question?
    !current_question.nil?
  end

  def end_question
    session.delete(:question_id)
    session.delete(:correct_answer)
    @current_question = nil
  end

end
