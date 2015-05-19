class GameController < ApplicationController
  before_action :logged_in_user,  only: [:index, :category, :category_select, :question]
  before_action :game_started,    only: [:question, :answer]
  before_action :continue_game,   only: [:question]
  before_action :question_asked,  only: [:answer]
  before_action :answer_exists,   only: [:answer]
  include SessionHelper

  # GET /game
  def index
  end

  # GET /game/category
  def category
    @categories = Category.all
  end

  # GET /game/category/1
  def category_select
    category = Category.find_by_id(params[:id])

    if category.nil?
      flash[:negative] = "Category not found."
      redirect_to game_category_url
    else
      play_category category
      redirect_to game_question_url
    end
  end

  # GET game/question
  def question
    @count_questions = Question.count_question_of_category(current_category.id, asked_questions)
    if @count_questions <= 0 && asked_questions.empty?
      flash[:negative] = "No Questions for this category found"
      end_playing
      redirect_to game_category_url
    elsif @count_questions <= 0
      flash[:negative] = "No more Questions available for this category"
      save_score
      redirect_to score_url
    else
      offset = rand(@count_questions)
      @question = Question.question_of_category(current_category.id, asked_questions, offset)
      ask @question
      @answers = current_answers
    end
  end

  # GET game/answer/1
  def answer
    @question = current_question
    @answerd = params[:answer]
    @answers = current_answers
    @correct_answer = current_answer
    @correct_answerd = @answerd == @correct_answer
    if !@correct_answerd
      save_score
    end
    end_question @correct_answerd
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:negative] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms a game is being played
    def game_started
      unless playing?
        flash[:negative] = "No Category selected"
        redirect_to game_category_url
      end
    end

    # Confirm that game con be continued
    def continue_game
      redirect_to score_url unless show_score?
    end

    # Confirm that a question is asked
    def question_asked
      redirect_to game_question_url unless question?
    end

    # Confirm that the answer exists
    def answer_exists
      redirect_to game_question_url unless current_answers.include?(params[:answer])
    end

    # Saves the reached score
    def save_score
      score = new Score
      score.score = current_score
      score.category = current_category
      score.user = current_user
    end

end
