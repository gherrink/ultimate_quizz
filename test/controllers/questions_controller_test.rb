require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @category = categories(:category)
    @question = questions(:question_one)
    @creator = users(:creator)
    @user = users(:fred)
  end

  test "should get redirected on index" do
    get :index
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on index" do
    log_in_as(@user)
    get :index
    assert_redirected_to root_path
  end

  test "should get index" do
    log_in_as(@creator)
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get redirected on new" do
    get :new
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on new" do
    log_in_as(@user)
    get :new
    assert_redirected_to root_path
  end

  test "should get new" do
    log_in_as(@creator)
    get :new
    assert_response :success
  end

  test "should get redirected on create" do
    assert_no_difference('Question.count') do
      post :create, question: {
        answer_correct: "something",
        answer_wrong_1: "stupid",
        answer_wrong_2: "may happen",
        answer_wrong_3: "on this question",
        rating: 5,
        question: "Is this a question?",
        category_ids: [@category.id]
        }
    end
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on create" do
    log_in_as(@user)
    assert_no_difference('Question.count') do
      post :create, question: {
        answer_correct: "something",
        answer_wrong_1: "stupid",
        answer_wrong_2: "may happen",
        answer_wrong_3: "on this question",
        rating: 5,
        question: "Is this a question?",
        category_ids: [@category.id]
        }
    end
    assert_redirected_to root_path
  end

  test "should create question" do
    log_in_as(@creator)
    assert_difference('Question.count') do
      post :create, question: {
        answer_correct: "something",
        answer_wrong_1: "stupid",
        answer_wrong_2: "may happen",
        answer_wrong_3: "on this question",
        rating: 5,
        question: "Is this a question?",
        category_ids: [@category.id]
        }
    end
    assert_redirected_to question_path(assigns(:question))
  end

  test "shoud not create wrong question" do
    log_in_as(@creator)
    assert_no_difference('Question.count') do
      post :create, question: {
        answer_correct: "a",
        answer_wrong_1: "b",
        answer_wrong_2: "b",
        answer_wrong_3: "c",
        rating: 0,
        question: "Is this a question?"
        }
    end

    assert_template 'questions/new'
  end

  test "should get redirected on show" do
    get :show, id: @question
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on show" do
    log_in_as(@user)
    get :show, id: @question
    assert_redirected_to root_path
  end

  test "should show question" do
    log_in_as(@creator)
    get :show, id: @question
    assert_response :success
  end

  test "should get redirected on edit" do
    get :edit, id: @question
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on edit" do
    log_in_as(@user)
    get :edit, id: @question
    assert_redirected_to root_path
  end

  test "should get edit" do
    log_in_as(@creator)
    get :edit, id: @question
    assert_response :success
  end

  test "should get redirected on update" do
    patch :update, id: @question, question: {
      answer_correct: @question.answer_correct,
      answer_wrong_1: @question.answer_wrong_1,
      answer_wrong_2: @question.answer_wrong_2,
      answer_wrong_3: @question.answer_wrong_3,
      rating: @question.rating,
      question: @question.question,
      category_ids: [@category.id] }
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on update" do
    log_in_as(@user)
    patch :update, id: @question, question: {
      answer_correct: @question.answer_correct,
      answer_wrong_1: @question.answer_wrong_1,
      answer_wrong_2: @question.answer_wrong_2,
      answer_wrong_3: @question.answer_wrong_3,
      rating: @question.rating,
      question: @question.question,
      category_ids: [@category.id] }
    assert_redirected_to root_path
  end

  test "should update question" do
    log_in_as(@creator)
    patch :update, id: @question, question: {
      answer_correct: @question.answer_correct,
      answer_wrong_1: @question.answer_wrong_1,
      answer_wrong_2: @question.answer_wrong_2,
      answer_wrong_3: @question.answer_wrong_3,
      rating: @question.rating,
      question: @question.question,
      category_ids: [@category.id] }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should get redirected on destroy" do
    assert_no_difference('Question.count') do
      delete :destroy, id: @question
    end
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on destroy" do
    log_in_as(@user)
    assert_no_difference('Question.count') do
      delete :destroy, id: @question
    end
    assert_redirected_to root_path
  end

  test "should destroy question" do
    log_in_as(@creator)
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end
end
