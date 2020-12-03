require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should remain at homepage if not logged in"do
    get root_url
    assert_response :success
  end

  test "should direct to personal dashboard if logged in" do
    get dashboard_url
    assert_response :success
    sign_in :user
  end
end
