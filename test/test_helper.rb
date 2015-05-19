ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start


require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password }
    else
      session[:user_id] = user.id
    end
  end

  def play(category)
    if integration_test?
      get :category_select, {:id => category.id.to_s}
    else
      session[:category_id] = category.id
      session[:show_score] = false
      session[:score] = 0
      session[:asked_questions] = []
    end
  end

  def is_playing?
    !session[:category_id].nil?
  end

  def ask(question)
    session[:question_id] = question.id
    session[:correct_answer] = question.answer_correct
    session[:current_answers] = [question.answer_correct, question.answer_wrong_1, question.answer_wrong_2, question.answer_wrong_3].shuffle
  end

  def is_asked?
    !session[:question_id].nil? && !session[:correct_answer].nil? && !session[:current_answers].nil?
  end

  def correct_answer
    session[:correct_answer]
  end
  
  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end
