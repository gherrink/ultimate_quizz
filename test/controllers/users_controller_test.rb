require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:fred)
    @admin = users(:admin)
  end

  test "should get index" do
    log_in_as(@admin)
    get :index
    assert_response :success
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
    log_in_as(@user)
    get :show, id: @user
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch :update, id: @user, user: {
      email: "new.mail@user.de",
      name: "New Name",
      password: "foobar3",
      password_confirm: "foobar3" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to root_url
  end

  test "should destroy" do
    log_in_as(@admin)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
  end
end
