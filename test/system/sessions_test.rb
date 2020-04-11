require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @user = users(:one)
  end

  test "should log in and log out" do
    visit login_url
    fill_in "Name:", with: @user.name
    fill_in "Password:", with: 'secret'
    click_on "Login"
    assert_selector "h1", text: "Welcome"
    click_button "Logout"
    assert_text "Logged out"
  end
end