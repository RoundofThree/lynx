require 'test_helper'

class BankAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bank_account_index_url
    assert_response :success
  end

end
