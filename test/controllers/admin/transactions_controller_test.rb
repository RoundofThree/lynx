require 'test_helper'

class Admin::TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'not logged in user should render 404' do
    get admin_transactions_url
    assert_response :missing
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

  # test show
  test "admin user should get transaction details by any user" do
    sign_in users(:admin)
    login_as_admin("abc")
    tx = transactions(:one)
    get admin_transaction_url(tx)
    assert_response :success
  end


  # test new (Yuxin)
  test "admin user should be able to create a transaction" do
    sign_in users(:admin)
    login_as_admin("abc")
    payer_account = accounts(:one)
    assert_difference('Transaction.count') do
      post admin_transactions_url, params: {transaction:{account: payer_account, dealer_account_number: '12345678901234',
         dealer_name: 'Nyx', amount: 1.0, currency: 'GBP', created_at:""}}
    end
    assert_redirected_to admin_transactions_url
  end

  # test create (Yuxin)

  # test edit (Yuxin)

  # test update (Yuxin)

  # test destroy
  test "admin user should be able to destroy any transaction" do
    sign_in users(:admin)
    login_as_admin("abc")
    tx = transactions(:one)
    assert_difference('Transaction.count', -1) do
      delete admin_transaction_url(tx)
    end
    assert_redirected_to admin_transactions_url
  end

end
