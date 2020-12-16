require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test index
  test "not logged in user should render 404" do
    get admin_accounts_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_accounts_url
    assert_response :missing
    sign_out :user
  end

  test "admin user should get accounts list" do
    sign_in users(:admin)
    login_as_admin("abc")
    get admin_accounts_url
    assert_response :success
  end

  # test show
  test "admin user should get account details by any user" do
    sign_in users(:admin)
    login_as_admin("abc")
    account = accounts(:one)
    get admin_account_url(account)
    assert_response :success
  end

  # test new (Yuxin)

  # test create (Yuxin)

  # test edit (Yuxin)

  # test update (Yuxin)


  # test destroy 
  test "admin user should be able to destroy any account" do 
    sign_in users(:admin) 
    login_as_admin("abc")
    account = accounts(:one) 

    assert_difference('Account.count', -1) do
      delete admin_account_url(account)
    end
    assert_redirected_to admin_accounts_url
  end

end
