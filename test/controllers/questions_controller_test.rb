require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
    @creator = users(:creator)
    log_in_as(@creator)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: {
        answer_correct: @question.answer_correct,
        answer_wrong_1: @question.answer_wrong_1,
        answer_wrong_2: @question.answer_wrong_2,
        answer_wrong_3: @question.answer_wrong_3,
        rating: @question.rating,
        question: @question.question
        }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    patch :update, id: @question, question: {
      answer_correct: @question.answer_correct,
      answer_wrong_1: @question.answer_wrong_1,
      answer_wrong_2: @question.answer_wrong_2,
      answer_wrong_3: @question.answer_wrong_3,
      question: @question.rating,
      question: @question.question }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end
end
