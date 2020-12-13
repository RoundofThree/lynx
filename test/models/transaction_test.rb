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

  # searching tests 
  test "searching should return the transactions with the keyword as a case-insensitive substring of the dealer name" do 
    results = Transaction.search("hAckEr")
    assert_equal 1, results.size
    assert_equal transactions(:two), results[0]
  end

  test "searching should return an empty list if there are no matching dealer names of transactions" do 
    results = Transaction.search("government")
    assert_equal 0, results.size 
  end 

  test "searching without keyword should return the whole list of transactions" do 
    results = Transaction.search("")
    assert_equal transactions(:one), results[0]
    assert_equal transactions(:two), results[1]
  end 

end
