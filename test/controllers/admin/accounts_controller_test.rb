require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do 
    sign_in users(:admin)
    login_as_admin("abc")
  end 

  teardown do 
    sign_out :user  
  end 

  # index tests 
  test 'not logged in user should render 404' do
    sign_out :user 
    get admin_accounts_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_out :user 
    sign_in users(:have_one_account)
    get admin_accounts_url
    assert_response :missing
  end

  test 'admin user should get accounts list' do
    get admin_accounts_url
    assert_response :success
  end

  test "admin user should be able to search and specify sorting criteria of accounts" do
    get admin_accounts_url, params: { sort_by: "last_created_at" }
    assert_response :success
    get admin_accounts_url, params: { sort_by: "first_created_at" }
    assert_response :success
    get admin_accounts_url, params: { sort_by: "last_updated_at" }
    assert_response :success
  end

  # edit tests
  test 'admin user should get edit' do
    get edit_admin_account_url(accounts(:one))
    assert_response :success
  end

  # new tests 
  test 'admin user should get new' do
    get new_admin_account_url
    assert_response :success
  end

  # show tests 
  test 'admin user should get account details by any user' do
    account = accounts(:one)
    get admin_account_url(account)
    assert_response :success
  end

  # create tests 
  test "admin user should be able to create an account " do
    accountuser = users(:have_one_account)
    account = Account.new(user: accountuser, account_number: "12345678901234", balance:"2313", currency:"GBP",
                          cvv:"132", expiry_date: "20221022")
    assert_difference('Account.count', 1) do
      post admin_accounts_url, params: { account: account.attributes }
    end
    assert_redirected_to admin_account_url(Account.last)  # recently created will be the last one 
  end

  test "create should fail if not all params are filled " do
    accountuser = users(:have_one_account)
    account = Account.new(user: accountuser)
    assert_no_difference('Account.count') do
      post admin_accounts_url, params: { account: account.attributes }
    end
    assert_template :new
  end

  # update tests 
  test "admin user should be able to update an account " do
    accountuser = users(:have_one_account)
    account = accounts(:one)
    assert_no_difference 'Account.count' do 
      patch admin_account_url(account), params: { account: { user: accountuser, 
                        account_number: "12345678901234", balance: 123,
                        currency: "GBP",cvv: "132", expiry_date:"20221022"}}
    end
    account.reload 
    assert_equal account.balance, 123
    assert_redirected_to admin_account_url(account)
  end

  test "update should fail if balance is negative" do
    accountuser = users(:have_one_account)
    account = accounts(:one)
    assert_no_difference 'Account.count' do 
      patch admin_account_url(account), params: { account: { user: accountuser, 
                        account_number: "12345678901234", balance: -123,
                        currency: "GBP",cvv: "132", expiry_date:"20221022"}}
    end
    assert_template :edit 
    account.reload 
    assert_not_equal account.balance, -123
  end

  # destroy tests
  test 'admin user should be able to destroy any account' do
    account = accounts(:one)
    assert_difference('Account.count', -1) do
      delete admin_account_url(account)
    end
    assert_redirected_to admin_accounts_url
  end
end
