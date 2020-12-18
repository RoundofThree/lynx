require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should remain at homepage if not logged in' do
    get root_url
    assert_response :success
  end
end
