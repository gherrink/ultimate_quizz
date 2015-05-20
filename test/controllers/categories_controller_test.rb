require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:category)
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
    assert_not_nil assigns(:categories)
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
    assert_no_difference('Category.count') do
      post :create, category: { name: @category.name }
    end
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on create" do
    log_in_as(@user)
    assert_no_difference('Category.count') do
      post :create, category: { name: @category.name }
    end
    assert_redirected_to root_path
  end

  test "should create category" do
    log_in_as(@creator)
    assert_difference('Category.count') do
      post :create, category: { name: "New category" }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "shoud not create wrong category" do
    log_in_as(@creator)
    assert_no_difference('Category.count') do
      post :create, category: { name: ""}
    end

    assert_template 'categories/new'
  end

  test "should get redirected on show" do
    get :show, id: @category
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on show" do
    log_in_as(@user)
    get :show, id: @category
    assert_redirected_to root_path
  end

  test "should show category" do
    log_in_as(@creator)
    get :show, id: @category
    assert_response :success
  end

  test "should get redirected on edit" do
    get :edit, id: @category
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on edit" do
    log_in_as(@user)
    get :edit, id: @category
    assert_redirected_to root_path
  end

  test "should get edit" do
    log_in_as(@creator)
    get :edit, id: @category
    assert_response :success
  end

  test "should get redirected on update" do
    patch :update, id: @category, category: { name: @category.name }
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on update" do
    log_in_as(@user)
    patch :update, id: @category, category: { name: @category.name }
    assert_redirected_to root_path
  end

  test "should update category" do
    log_in_as(@creator)
    patch :update, id: @category, category: { name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should get redirected on destroy" do
    assert_no_difference('Category.count') do
      delete :destroy, id: @category
    end
    assert_redirected_to login_path
  end

  test "should get redirected with wrong user on destory" do
    log_in_as(@user)
    assert_no_difference('Category.count') do
      delete :destroy, id: @category
    end
    assert_redirected_to root_path
  end

  test "should destroy category" do
    log_in_as(@creator)
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
