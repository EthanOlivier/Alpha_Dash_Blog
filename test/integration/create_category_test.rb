require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "Get New Category and Create New Categor Form" do
    get "/categories/new"
    assert :success
    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", @response.body
  end
end
