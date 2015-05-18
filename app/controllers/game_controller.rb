class GameController < ApplicationController
  before_action :logged_in_user,  only: [:index, :category, :category_select, :question]
  before_action :game_started,    only: [:question]
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

  # GET /question
  def question
    questions = Question.question_of_category(current_category.id)
    if questions.empty?
      flash[:negative] = "No Questions for this category found"
      end_playing
      redirect_to game_category_url
    else
      @question = questions.first
    end
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
end
