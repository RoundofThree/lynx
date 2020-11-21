require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  # show tests
  test "should get show" do
    get transactions_show_url
    assert_response :success
  end

  # new tests
  test "should get new" do
    get transactions_new_url
    assert_response :success
  end

  # create tests
  test "should get create" do
    get transactions_create_url
    assert_response :success
  end

  test "transaction without account_id should fail" do

  end

  test "transaction with a negative amount should fail" do

  end

  test "transaction without payee account number should fail" do

  end

  test "transaction without payee fullname should fail" do
    
  end

end
