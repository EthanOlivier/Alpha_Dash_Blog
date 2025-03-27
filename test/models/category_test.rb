require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Sports")
  end

  test "Category should be valid" do
    assert @category.valid?
  end

  test "Category cannot be empty" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "Category must me unique" do
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "Category cannot be more than 25 characters" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "Category cannot be less than 3 characters" do
    @category.name = "a" * 2
    assert_not @category.valid?
  end
end
