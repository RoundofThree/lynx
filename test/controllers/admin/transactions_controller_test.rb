require 'test_helper'

class Admin::TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'not logged in user should render 404' do
    get admin_transactions_url
    assert_response :missing
  end


  test "admin user should be able to search and specify sorting criteria of transactions" do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_transactions_url, params: { sort_by: "last_created_at" }
    assert_response :success
    get admin_transactions_url, params: { sort_by: "first_created_at" }
    assert_response :success
    get admin_transactions_url, params: { sort_by: "amount" }
    assert_response :success
  end


  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_transactions_url
    assert_response :missing
    sign_out :user
  end

  test "admin user should get transactions list" do
    sign_in users(:admin)
    login_as_admin("abc")
    get admin_transactions_url
    assert_response :success
    sign_out :user
  end

  test "not admin user should not get transactions list" do
    get admin_transactions_url
    assert_response :missing
    sign_out :user
  end

  test 'admin user should get new' do
    sign_in users(:admin)
    login_as_admin('abc')
    get "/admin/transactions/new"
    assert_response :success
    end
  test "admin user should get transaction details by any user" do
    sign_in users(:admin)
    login_as_admin("abc")
    tx = transactions(:one)
    get admin_transaction_url(tx)
    assert_response :success
  end

  test "not admin user should not get transaction details by any user" do

    tx = transactions(:one)
    get admin_transaction_url(tx)
    assert_response :missing
  end

  test 'admin user should get edit' do
        sign_in users(:admin)
        login_as_admin('abc')
        tx = transactions(:one)
        get edit_admin_transaction_url(tx)
        assert_response :success
  end

  test 'not admin user should not get edit' do
        tx = transactions(:one)
        get edit_admin_transaction_url(tx)
        assert_response :missing
  end

  test "admin user should be able to create a transaction" do
    sign_in users(:admin)
    login_as_admin("abc")
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0, currency: 'GBP')
    assert_difference('Transaction.count') do
      post admin_transactions_url, params: { transaction: transaction.attributes }
    end
    assert_redirected_to [:admin, Transaction.last]
  end

  test "not admin user should not be able to create a transaction" do

    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0, currency: 'GBP')
    assert_no_difference('Transaction.count') do
      post admin_transactions_url, params: { transaction: transaction.attributes }
    end
    assert_response :missing
  end

  test "create should fail if some params are not filled" do
    sign_in users(:admin)
    login_as_admin("abc")
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0)
    assert_no_difference('Transaction.count') do
      post admin_transactions_url, params: { transaction: transaction.attributes }
    end
    assert_response :success
  end

  test "admin user should be able to update a transaction" do
    sign_in users(:admin)
    login_as_admin("abc")
    transaction = transactions(:one)
    payer_account = accounts(:one)
    patch admin_transaction_url(transaction), params: {transaction:
       {account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
         amount: 1.0, currency: 'GBP'}}
    assert_redirected_to [:admin, Transaction.last]
  end

  test "not admin user should not be able to update a transaction" do

    transaction = transactions(:one)
    payer_account = accounts(:one)
    patch admin_transaction_url(transaction), params: {transaction:
       {account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
         amount: 1.0, currency: 'GBP'}}
    assert_response :missing
  end

  test "update should fail if dealer_account_number is not 14 characters" do
    sign_in users(:admin)
    login_as_admin("abc")
    transaction = transactions(:one)
    payer_account = accounts(:one)
    assert_no_difference 'User.count' do
    patch admin_transaction_url(transaction), params: {transaction:
       {account: payer_account, dealer_account_number: '12345622278901234', dealer_name: 'Nyx',
      currency: 'GBP'}}
    end
    assert_response :success
  end

  test "admin user should be able to destroy any transaction" do
    sign_in users(:admin)
    login_as_admin("abc")
    tx = transactions(:one)
    assert_difference('Transaction.count', -1) do
      delete admin_transaction_url(tx)
    end
    assert_redirected_to admin_transactions_url
  end

  test "not admin user should not be able to destroy any transaction" do
    tx = transactions(:one)
    assert_no_difference('Transaction.count', -1) do
      delete admin_transaction_url(tx)
    end
    assert_response :missing
  end

end
