require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: "user.user@someware.de",
          name: "user2",
          password: "foobar2",
          password_confirm: "foobar2"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should not create user with wrong input" do
    assert_no_difference('User.count') do
      post :create, user: { email: "user.user",
          name: "",
          password: "foo",
          password_confirm: "foobar"}
    end

    assert_template 'users/new'
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: {
      email: "user.user@someware.de",
      name: "user3",
      password: "foobar3",
      password_confirm: "foobar3" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
