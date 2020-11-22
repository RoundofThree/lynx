require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup 

  # show tests
  test "should get show" do
    get transactions_show_url
    assert_response :success
  end

  # new tests
  test "user with an account should get new" do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in users(:one)
    get transactions_new_url
    assert_response :success
    sign_out :user
  end

  test "user without account should not get new" do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in users(:two)
    get transactions_new_url
    assert_response :redirect 
    sign_out :user
  end 

  # create tests

  test "create transaction without account_id should fail" do
    transaction = transactions(:two)
    transaction.payer_account = nil 
    assert_no_difference 'Transaction.count' do
      post transactions_path, params: transaction 
    end 
  end

end
