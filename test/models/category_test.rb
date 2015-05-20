require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "New Category")
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "name exists" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "name already exists in db" do
    @category.name = categories(:category).name
    assert_not @category.valid?
  end

  test "name to short" do
    @category.name = "a"
    assert_not @category.valid?
  end
end
