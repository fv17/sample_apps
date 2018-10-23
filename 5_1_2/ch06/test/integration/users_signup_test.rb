require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "ユーザー情報が無効な場合、ユーザーは作成されない" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: "",
        email: "user@invalid",
        password: "foobar",
        password_confirmation: "foobar" } }
    end
    assert_template 'users/new'
  end

  test "ユーザー情報が有効な場合、ユーザーが作成される" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: "Example User",
        email: "user@example.com",
        password: "foobar",
        password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
