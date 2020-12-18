require 'test_helper'

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @account = accounts(:one)
  end

  test 'not logged in user should render 404' do
    get admin_accounts_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_accounts_url
    assert_response :missing
    sign_out :user
  end

  test 'admin user should get accounts list' do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_accounts_url
    assert_response :success
  end


  test 'admin user should get edit' do
    sign_in users(:admin)
    login_as_admin('abc')
    get edit_account_url(@account)
    assert_response :success
  end

  test 'admin user should get new' do
    sign_in users(:admin)
    login_as_admin('abc')
    get "/admin/accounts/new"
    assert_response :success
  end

  test "admin user should be able to search and specify sorting criteria of accounts" do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_accounts_url, params: { sort_by: "last_created_at" }
    assert_response :success
    get admin_accounts_url, params: { sort_by: "first_created_at" }
    assert_response :success
    get admin_accounts_url, params: { sort_by: "last_updated_at" }
    assert_response :success
  end


  # show
  test 'admin user should get account details by any user' do
    sign_in users(:admin)
    login_as_admin('abc')
    account = accounts(:one)
    get admin_account_url(account)
    assert_response :success
  end

  # create
  test "admin user should be able to create an account " do
    sign_in users(:admin)
    login_as_admin('abc')
    accountuser = users(:have_one_account)

    account = Account.new(user: accountuser, account_number: "12345678901234", balance:"2313", currency:"GBP",
    cvv:"132", expiry_date:"20221022")
      assert_difference('Account.count') do
      post admin_accounts_url, params: { account: account.attributes}
    end
    assert_redirected_to [:admin, Account.last]
  end

  test "create should fail if not all params are filled " do
    sign_in users(:admin)
    login_as_admin('abc')
    accountuser = users(:have_one_account)
    account = Account.new(user: accountuser)
      assert_no_difference('Account.count') do
      post admin_accounts_url, params: { account: account.attributes}
    end
    assert_response :success
  end

  # update
  test "admin user should be able to update an account " do
    sign_in users(:admin)
    login_as_admin('abc')
    accountuser = users(:have_one_account)
    account = accounts(:one)
    patch admin_account_url(account), params: {
      account:{ user: accountuser, account_number: "12345678901234", balance:"2313",
      currency:"GBP",cvv:"132", expiry_date:"20221022"}}
      assert_redirected_to [:admin, Account.last]
  end

  test "update should fail if balance is negative" do
    sign_in users(:admin)
    login_as_admin('abc')
    accountuser = users(:have_one_account)
    account = accounts(:one)
    patch admin_account_url(account), params: {
      account:{ balance:"-2313",user: accountuser, account_number: "999999",
      currency:"GBP",cvv:"1321", expiry_date:"20221022"}}
      assert_response :success

  end

  # destroy
  test 'admin user should be able to destroy any account' do
    sign_in users(:admin)
    login_as_admin('abc')
    account = accounts(:one)
    assert_difference('Account.count', -1) do
      delete admin_account_url(account)
    end
    assert_redirected_to admin_accounts_url
  end
end
