require "test_helper"

class ArticleCreationTest < ActionDispatch::IntegrationTest
  setup do
    @non_admin_user = User.create(username: "johndoe", email: "example@email.com",
                                  password: "password", admin: false)
    sign_in(@non_admin_user)
  end

  test "Create New Article" do
    get "/articles/new"
    assert :success
    assert_difference("Article.count", 1) do
      post articles_path, params: { article: { title: "Int Test", description: "Int Test Description", category_id: [ 1, 2, 3 ] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Int Test", @response.body
  end
end
