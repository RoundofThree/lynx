require 'test_helper'

class GeneratorControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get index" do
    sign_in users(:have_two_accounts)
    # user = users(:have_two_accounts)
    get generator_url
    assert_response :success
  end
  
  test "generate transactions should increase the number of transactions on the accounts" do
    user = users(:have_two_accounts)
    sign_in user
    accounts = user.accounts
    assert_difference('Transaction.count', 20) do
      get generator_url
      post generator_generate_transactions_url
    end
  end

end
