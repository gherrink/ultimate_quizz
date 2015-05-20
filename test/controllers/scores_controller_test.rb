require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  setup do
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scores)
  end

  test "shoud show score" do
    show_score 10
    get :index
    assert_response :success
    assert_template 'scores/index'
    assert_select "div.ui.positiv.message", {count: 1, text: "You got it. Your score is 10."}
  end
end
