require 'test_helper'

class CategoryEditTest < ActionDispatch::IntegrationTest
  def setup
    @creator = users(:creator)
    @category = categories(:category)
  end

  test "unsuccessful edit" do
    log_in_as(@creator)
    get edit_category_path(@category)
    assert_template 'categories/edit'
    patch category_path(@category), category: {
      name: ""
    }
    assert_template 'categories/edit'
  end
end
