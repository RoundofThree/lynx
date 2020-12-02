require 'test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "transaction with existing account, 14 digits payee account number, payee fullname, positive amount and currency is valid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "12345678901234", payee_fullname: "Nyx", amount: 1.0, currency: "GBP")
    assert transaction.valid?
  end

  test "transaction with no payer account is invalid" do
    transaction = Transaction.new(payer_account: nil, payee_account_number: "12345678901234", payee_fullname: "Nyx", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without payee account number is invalid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "", payee_fullname: "Nyx", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without payee fullname is invalid" do 
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "12345678901234", payee_fullname: "", amount: 1.0, currency: "GBP")
    assert_not transaction.valid?
  end  

  test "transaction with zero amount is invalid" do
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "12345678901234", payee_fullname: "Nyx", amount: 0.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction with negative amount is invalid" do 
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "12345678901234", payee_fullname: "Nyx", amount: -1.0, currency: "GBP")
    assert_not transaction.valid?
  end

  test "transaction without currency is invalid" do 
    payer_account = accounts(:one)
    transaction = Transaction.new(payer_account: payer_account, payee_account_number: "12345678901234", payee_fullname: "Nyx", amount: 1.0, currency: "")
    assert_not transaction.valid?
  end

end
