require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "should not save transaction without payer account" do
    transaction = transactions(:one)
    transaction.payer_account = nil
    assert !transaction.save 
  end



end
