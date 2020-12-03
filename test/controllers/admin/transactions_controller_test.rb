require 'test_helper'

class Admin::TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "not logged in user should render 404" do
    get admin_transactions_url
    assert_response :missing
  end

  test "not admin user should render 404" do 
    sign_in users(:have_one_account)
    get admin_transactions_url
    assert_response :missing
    sign_out :user 
  end 

  test "admin user should get transactions list" do 
    sign_in users(:admin)
    get admin_transactions_url
    assert_response :success
    sign_out :user
  end 

  # test show 
  test "admin user should get transaction details by any user" do 
    sign_in users(:admin)
    tx = transactions(:one)
    get admin_transaction_url(tx)
    assert_response :success
  end

  # test new (Yuxin)

  # test create (Yuxin)

  # test edit (Yuxin)

  # test update (Yuxin)

  # test destroy 
  test "admin user should be able to destroy any transaction" do 
    sign_in(:admin) 
    tx = transactions(:one)
    assert_difference('Transaction.count', -1) do
      delete admin_transaction_url(tx)
    end
    assert_redirect_to admin_transactions_url
  end 

end
