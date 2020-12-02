require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # TODO 
  test "not admin user should be redirected to normal user dashboard" do 
    get dashboard_url
    assert_redirected_to new_user_session_url
  end 

  test "admin user should get admin dashboard" do 
    sign_in users(:admin)
    get admin_dashboard_url
    assert_response :success
    sign_out :user
  end 



end
