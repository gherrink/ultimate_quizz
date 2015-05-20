require 'test_helper'

class PlayGameTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fred)
    @category = categories(:category)
  end

  test "play a game with first questing wrong" do
    score_count = Score.count
    log_in_as @user
    play @category
    assert_redirected_to game_question_url

    ask_question_wrong

    assert show_score?, "Score shoud be showen"
    assert score_count == Score.count, "A score with 0 can't be saved"
  end

  test "play a game with second question wrong" do
    score_count = Score.count
    @score = 0
    log_in_as @user
    play @category
    assert_redirected_to game_question_url

    ask_question_correct
    ask_question_wrong

    assert show_score?, "Score shoud be showen"
    assert score_count + 1 == Score.count, "The score is not saved"
    assert current_score == @score, "Score is not correct expected " + @score.to_s + " but was " + current_score.to_s
  end

  test "play a game until no more questions are available" do
    score_count = Score.count
    @score = 0
    log_in_as @user
    play @category
    assert_redirected_to game_question_url

    for i in 1..@category.questions.count
      ask_question_correct
    end

    get game_question_url
    assert_redirected_to scores_path

    assert show_score?, "Score shoud be showen"
    assert score_count + 1 == Score.count, "The score is not saved"
    assert current_score == @score, "Score is not correct expected " + @score.to_s + " but was " + current_score.to_s
  end

  private
    def ask_question_wrong
      get game_question_url
      assert_response :success
      assert_template 'game/question'
      assert is_playing?
      assert is_asked?

      question = Question.find(current_question_id)
      assert_asked question

      wrong_answer = question.answer_wrong_1
      put game_answer_path(answer: wrong_answer)
      assert_response :success
      assert_template 'game/answer'
      assert_not is_playing?
      assert_not is_asked?
      assert_answer_wrong wrong_answer, question
    end

    def ask_question_correct
      get game_question_url
      assert_response :success
      assert_template 'game/question'
      assert is_playing?
      assert is_asked?

      question = Question.find(current_question_id)
      assert_asked question
      @score = @score + question.rating

      put game_answer_path(answer: question.answer_correct)
      assert_response :success
      assert_template 'game/answer'
      assert is_playing?
      assert_not is_asked?
      assert_answer_correct question

      assert @score == current_score, "Score is not correct expected " + @score.to_s + " but was " + current_score.to_s
      assert_not show_score?, "Score can't be displayed when correct answer"
    end

    def assert_asked(question)
      assert_select "h3", {count: 1, text: question.question}
      assert_select "a div.ui.button", {count: 1, text: question.answer_correct}
      assert_select "a div.ui.button", {count: 1, text: question.answer_wrong_1}
      assert_select "a div.ui.button", {count: 1, text: question.answer_wrong_2}
      assert_select "a div.ui.button", {count: 1, text: question.answer_wrong_3}
    end

    def assert_answer_wrong(wrong_answer, question)
      assert_answer_for question
      assert_select "div.ui.button.negative", {count: 1, text: wrong_answer}
      assert_select "div.ui.button", {count: 1, text: "Show Score"}
    end

    def assert_answer_correct(question)
      assert_answer_for question
      assert_select "div.ui.button", {count: 1, text: "Next Question"}
    end

    def assert_answer_for(question)
      assert_select "h3", {count: 1, text: question.question}
      assert_select "div.ui.button.positive", {count: 1, text: question.answer_correct}
      assert_select "div.ui.button", {count: 1, text: question.answer_wrong_1}
      assert_select "div.ui.button", {count: 1, text: question.answer_wrong_2}
      assert_select "div.ui.button", {count: 1, text: question.answer_wrong_3}
    end
end
