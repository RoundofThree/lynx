require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  #show tests
  test "should properly get show if the logged in user owns this account" do
    user = users(:have_two_accounts)
    sign_in user
    account = accounts(:one)
    get account_url(account)
    assert_response :success
  end
  
  test "should not get show if not logged in" do
    account = accounts(:one)
    get account_url(account)
    assert_redirected_to new_user_session_url
  end

  test "should redirect to dashboard if logged in user does not own this account " do
    user = users(:have_one_account)
    sign_in user
    account = accounts(:one)
    get account_url(account)
    assert_redirected_to dashboard_url
  end

end
