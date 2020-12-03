require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "should direct to personal dashboard if logged in" do
    get dashboard_url
    assert_response :success
    sign_in :user
  end

    test "should remain at homepage if not logged in" do
    get root_url
    assert_response :success
  end

end
