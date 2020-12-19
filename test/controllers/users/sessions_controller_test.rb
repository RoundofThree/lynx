require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # new tests 
  test "should get new" do 
    get new_user_session_url
    assert_response :success
  end 

  # destroy tests
  test "should sign out" do 
    delete destroy_user_session_url 
    assert_redirected_to root_url 
  end 

  # create tests 
  test "should sign in with a valid user" do
    post user_session_url, params: { user: { email: "lol1@gmail.com", password: "1234567890"} }
    follow_redirect!
    assert_template "dashboard/index"
  end

  test "should not sign in with an inexisting user" do
    post user_session_url, params: { user: { email: "hu@qq.com", password: "qwerty" } }
    assert_template "users/sessions/new"
  end

end