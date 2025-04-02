require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
    test "Sign in user" do
      get "/users/new"
      assert :success
      assert_difference("User.count", 1) do
        post users_path, params: { user: { username: "int_test_user", email: "inttest@email.com", password: "password" } }
        assert_response :redirect
      end
      follow_redirect!
      assert_response :success
      assert_match "int_test_user", @response.body
    end
end
