require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # new tests 
  test "should get new" do 
    get new_user_password_url 
    assert_response :success
  end 

  # create tests 
  test "should redirect to sign in page after trying to recover the forgotten password (fake recovery though)" do
    post user_password_url, params: { email: "lol1@gmail.com" }
    assert_redirected_to new_user_session_url
  end

end