require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # include sign_in and sign_out helpers

  # show tests
  test 'should not get show if not logged in' do
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_redirected_to new_user_session_url
  end

  test 'should get show if transaction is done by logged in user' do
    user = users(:have_two_accounts)
    sign_in user
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_response :success
  end

  test 'should not get show if transaction is not done by logged in user' do
    user = users(:have_one_account)
    sign_in user
    transaction = transactions(:one)
    get transaction_url(transaction)
    assert_redirected_to dashboard_url
  end

  # new tests
  test 'should get new if user has an account' do
    user = users(:have_one_account)
    sign_in user
    get new_transaction_url
    assert_response :success
  end

  test 'should not get new if user does not have an account' do
    user = users(:have_no_accounts)
    sign_in user
    get new_transaction_url
    assert_redirected_to dashboard_url
  end

  # create tests

  test 'create transaction if user has not logged in should fail' do
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0)
    assert_no_difference 'Transaction.count' do
      post transactions_url, params: { transaction: transaction.attributes }
    end
    assert_redirected_to new_user_session_url
  end

  test 'create transaction with valid account_id, payee account number and amount should succeed' do
    user = users(:have_two_accounts)
    sign_in user
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0)
    assert_difference('Transaction.count', 1) do
      post transactions_url, params: { transaction: transaction.attributes }
    end
    transaction = Transaction.last
    assert_redirected_to transaction_url(transaction)
  end

  test 'create transaction with negative amount should fail' do
    user = users(:have_two_accounts)
    sign_in user
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: -1.0)
    assert_no_difference 'Transaction.count' do
      post transactions_url, params: { transaction: transaction.attributes }
    end
    assert_redirected_to new_transaction_url
  end

  test 'create transaction without account_id should fail' do
    user = users(:have_two_accounts)
    sign_in user
    assert_no_difference 'Transaction.count' do
      post transactions_url,
           params: { transaction: { account: '', dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                    amount: 1.0 } }
    end
    assert_redirected_to new_transaction_url
  end

  test 'create transaction with an account_id that does not belong to logged in user should fail' do
    user = users(:have_one_account)
    sign_in user
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                  amount: 1.0)
    assert_no_difference 'Transaction.count' do
      post transactions_url, params: { transaction: transaction.attributes }
    end
    assert_redirected_to new_transaction_url
  end

  test 'create transaction with insufficient balance account should fail' do
    user = users(:have_two_accounts)
    sign_in user
    payer_account = accounts(:one)
    assert_no_difference 'Transaction.count' do
      post transactions_url,
           params: { transaction: { account: payer_account, dealer_account_number: '12345678901234', dealer_name: 'Nyx',
                                    amount: 1_000_000.0 } }
    end
    assert_redirected_to new_transaction_url
  end

  test 'create transaction without dealer should fail' do
    user = users(:have_two_accounts)
    sign_in user
    payer_account = accounts(:one)
    assert_no_difference 'Transaction.count' do
      post transactions_url,
           params: { transaction: { account: payer_account, amount: 1.0 } }
    end
    assert_redirected_to new_transaction_url
  end

  test 'create transaction without valid payee account number should fail' do
    user = users(:have_two_accounts)
    sign_in user
    payer_account = accounts(:one)
    assert_no_difference 'Transaction.count' do
      post transactions_url,
           params: { transaction: { account: payer_account, dealer_account_number: '1234', dealer_name: 'Nyx',
                                    amount: 1_000_000.0 } }
    end
    assert_redirected_to new_transaction_url
  end
end
