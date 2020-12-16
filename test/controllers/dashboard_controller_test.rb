require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect to root if not logged in" do
    get dashboard_url
    assert_redirected_to new_user_session_url
  end

  test "should get index if logged in" do
    sign_in users(:have_two_accounts)
    get dashboard_url
    assert_response :success
    sign_out :user
  end

end
