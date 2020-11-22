require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:have_two_accounts)
  end

  teardown do
    sign_out :user
  end

  # show tests
  test "should get show if transaction is done by user" do
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_response :success
  end

  test "should not get show if transaction is not done by user" do
    sign_in users(:have_one_account)
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_response :error  # ?
    sign_out :user
  end

  # new tests
  test "user with an account should get new" do
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    get new_transaction_url
    assert_response :success
  end

  test "user without account should not get new" do
    sign_in users(:have_no_accounts)
    get new_transaction_url
    assert_response :redirect
    sign_out :user
  end

  # create tests

  test "create transaction without account_id should fail" do
    transaction = transactions(:two)
    transaction.payer_account = nil
    assert_no_difference 'Transaction.count' do
      post transactions_path(transaction)
    end
    post transactions_path(transaction)
    assert_redirected_to new_transaction_url
  end

  test "create transaction with insufficient balance account should fail" do
    transaction = transactions(:two)
    assert_no_difference 'Transaction.count' do
      post transactions_path(transaction)
    end
    post transactions_path(transaction)
    assert_redirected_to new_transaction_url
  end

  test "create transaction without valid payee account number should fail" do
    transaction = transactions(:one)
    transaction.payee_account_number = "123456"  # too short
    assert_no_difference 'Transaction.count' do
      post transactions_path(transaction)
    end
    post transactions_path(transaction)
    assert_redirected_to new_transaction_url
  end

  test "create transaction with valid payee account number should succeed" do
    transaction = transactions(:one)
    transaction.payee_account_number = "12345678901234"  # 14 digits
    assert_difference 'Transaction.count' do
      post transactions_path(transaction)
    end
    assert_redirected_to transaction_path(assign(:transaction))
  end

end
