require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "transaction with existing account, 14 digits payee account number, payee fullname, positive amount and currency is valid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: "12345678901234", dealer_name: "Nyx", amount: 1.0, currency: "GBP")
    assert transaction.valid?
  end

  test "transaction with no payer account is invalid" do
    transaction = Transaction.new(account: nil, dealer_account_number: "12345678901234", dealer_name: "Nyx", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without payee account number is invalid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: "", dealer_name: "Nyx", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without payee fullname is invalid" do 
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: "12345678901234", dealer_name: "", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end  

  test "transaction with zero amount is invalid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: "12345678901234", dealer_name: "Nyx", amount: 0.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without currency is invalid" do 
    payer_account = accounts(:one)
    transaction = Transaction.new(account: payer_account, dealer_account_number: "12345678901234", dealer_name: "Nyx", amount: 1.0, currency: "")
    assert_not transaction.valid?
  end

end
