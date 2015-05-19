require 'test_helper'

class GameControllerTest < ActionController::TestCase

  setup do
    @category = categories(:category)
    @empty_category = categories(:empty)
    @creator = users(:creator)
    @question = questions(:question_one)
  end

  test "index shoud redirected to login when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "category list shoud redirected to login when not logged in" do
    get :category
    assert_redirected_to login_url
  end

  test "category select shoud redirected to login when not logged in" do
    get :category_select, {:id => @category.id.to_s}
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@creator)
    get :index
    assert_response :success
  end

  test "should get category list" do
    log_in_as(@creator)
    get :category
    assert_response :success
    assert_template 'game/category'
  end

  test "shoud redirected to question on correct category" do
    log_in_as(@creator)
    get :category_select, {:id => @category.id.to_s}
    assert_redirected_to game_question_path
  end

  test "shoud redirected to category on false category" do
    log_in_as(@creator)
    get :category_select, {:id => 0}
    assert_redirected_to game_category_path
  end

  test "question select shoud redirected to login when not logged in" do
    get :question
    assert_redirected_to login_url
  end

  test "question select shoud redirected to category when no game is started" do
    log_in_as(@creator)
    get :question
    assert_redirected_to game_category_url
  end

  test "question select shoud show question" do
    log_in_as(@creator)
    play @category
    get :question
    assert_response :success
    assert_template 'game/question'
    assert is_playing?
  end

  test "question select shoud redirect to category when no questions are available" do
    log_in_as(@creator)
    play @empty_category
    get :question
    assert_redirected_to game_category_url
    assert_not is_playing?
  end

  test "answer shoud redirect to question if no question was asked" do
    log_in_as(@creator)
    play @category
    get :answer, {:answer => 1}
    assert_redirected_to game_question_url
  end

  test "answer shoud redirect to question if answer is incorrect" do
    log_in_as(@creator)
    play @category
    get :question
    assert_response :success
    assert_template 'game/question'
    assert is_playing?
    get :answer, {:answer => 5}
    assert_redirected_to game_question_url
  end

  test "answer shoud be displayed" do
    log_in_as(@creator)
    play @category
    ask @question
    get :answer, {:answer => correct_answer}
    assert_response :success
    assert_template 'game/answer'
  end

end
