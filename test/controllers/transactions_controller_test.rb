require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # show tests !!!! inaccurate
  test "should get show if transaction is done by user" do
    sign_in users(:one)
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_response :success
    sign_out :user 
  end

  # new tests
  test "user with an account should get new" do
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in users(:one)
    get new_transaction_url
    assert_response :success
    sign_out :user
  end

  test "user without account should not get new" do
    sign_in users(:two)
    get new_transaction_url
    assert_response :redirect
    sign_out :user
  end

  # create tests

  test "create transaction without account_id should fail" do
    transaction = transactions(:two)
    # transaction.payer_account = nil
    assert_no_difference 'Transaction.count' do
      post transactions_path(transaction)
    end
  end

  test "create transaction with insufficient balance account should fail" do
    transaction = transactions(:two)

  end

end
