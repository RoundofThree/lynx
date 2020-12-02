require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "not logged in user should render 404" do
    get admin_accounts_url
    assert_response :missing
  end

  test "not admin user should render 404" do 
    sign_in users(:have_one_account)
    get admin_accounts_url
    assert_response :missing
    sign_out :user 
  end 

  test "admin user should get admin dashboard" do 
    sign_in users(:admin)
    get admin_accounts_url
    assert_response :success
    sign_out :user
  end 

end
