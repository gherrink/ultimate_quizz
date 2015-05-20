require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    @question = Question.new(question: "Is this a test question?",
                        answer_correct: "correct answer",
                        answer_wrong_1: "wrong answer 1",
                        answer_wrong_2: "wrong answer 2",
                        answer_wrong_3: "wrong answer 3",
                        rating: 10)
    @question.categories << categories(:category)
    @existing = questions(:question_one)
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "question exists" do
    @question.question = nil
    assert_not @question.valid?
  end

  test "question already exists in db" do
    @question.question = @existing.question
    assert_not @question.valid?
  end

  test "question to short" do
    @question.question = "as"
    assert_not @question.valid?
  end

  test "correct answer exists" do
    @question.answer_correct = nil
    assert_not @question.valid?
  end

  test "correct answer to short" do
    @question.answer_correct = "a"
    assert_not @question.valid?
  end

  test "wrong answer 1 exists" do
    @question.answer_wrong_1 = nil
    assert_not @question.valid?
  end

  test "wrong answer 1 to short" do
    @question.answer_wrong_1 = "a"
    assert_not @question.valid?
  end

  test "wrong answer 2 exists" do
    @question.answer_wrong_2 = nil
    assert_not @question.valid?
  end

  test "wrong answer 2 to short" do
    @question.answer_wrong_2 = "a"
    assert_not @question.valid?
  end

  test "wrong answer 3 exists" do
    @question.answer_wrong_3 = nil
    assert_not @question.valid?
  end

  test "wrong answer 3 to short" do
    @question.answer_wrong_3 = "a"
    assert_not @question.valid?
  end

  test "rating exists" do
    @question.rating = nil
    assert_not @question.valid?
  end

  test "rating to big" do
    @question.rating = 21
    assert_not @question.valid?
  end

  test "rating to small" do
    @question.rating = 0
    assert_not @question.valid?
  end

  test "answer wrong 1 same as answer correct" do
    @question.answer_wrong_1 = @question.answer_correct
    assert_not @question.valid?
  end

  test "answer wrong 2 same as answer correct" do
    @question.answer_wrong_2 = @question.answer_correct
    assert_not @question.valid?
  end

  test "answer wrong 3 same as answer correct" do
    @question.answer_wrong_3 = @question.answer_correct
    assert_not @question.valid?
  end

  test "answer wrong 1 same as answer wrong 2" do
    @question.answer_wrong_2 = @question.answer_wrong_1
    assert_not @question.valid?
  end

  test "answer wrong 1 same as answer wrong 3" do
    @question.answer_wrong_3 = @question.answer_wrong_1
    assert_not @question.valid?
  end

  test "answer wrong 2 same as answer wrong 3" do
    @question.answer_wrong_3 = @question.answer_wrong_2
    assert_not @question.valid?
  end

end
