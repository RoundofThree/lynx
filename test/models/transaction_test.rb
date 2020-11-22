require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  setup do
    # @current_user = users(:one)  # has account :one
    @account = accounts(:one)
  end

  test "should not save transaction without payer account" do
    transaction = transactions(:one)
    transaction.payer_account = nil
    assert_not transaction.valid?
  end



end
