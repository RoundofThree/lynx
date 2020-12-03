require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should remain at homepage if not logged in"do
    get root_url
    assert_response :success
  end

  test "should direct to personal dashboard if logged in" do
    sign_in users(:have_one_account)
    get root_url
    assert_redirected_to dashboard_url
    sign_out :user
  end
end
