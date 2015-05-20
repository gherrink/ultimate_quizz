class ScoresController < ApplicationController
  include SessionHelper

  # GET /scores
  # GET /scores.json
  def index
    if show_score?
      flash[:positiv] = "You got it. Your score is " +  current_score.to_s + "."
      delete_score
    end

    @scores = Score.all.order(score: :desc)
  end

end
