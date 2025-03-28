require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email: "example@email.com",
                              password: "password", admin: true)
    sign_in(@admin_user)
  end
  test "Get New Category and Create New Categor Form" do
    get "/categories/new"
    assert :success
    assert_difference("Category.count", 1) do
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", @response.body
  end

  test "Get New Category Form and Reject Invalid Category Submission" do
    get "/categories/new"
    assert :success
    assert_no_difference("Category.count") do
      post categories_path, params: { category: { name: " " } }
    end
    assert_match "The following errors prevented the ", @response.body
    assert_select "div.alert"
    assert_select "h4.alert-heading"
  end
end
