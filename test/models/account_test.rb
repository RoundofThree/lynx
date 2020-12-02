require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "account with payer account, balance 1000.10, account number 12345678, cvv 123, expiry month 1 and expiry year 2022 should be valid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: 1000.10, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert account.valid?
  end

  test "account with no user should be invalid" do
    account = Account.new(user: nil, balance: 1000.10, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end

  test "The balance of an account should be trimmed to 2 decimal places" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: 111.123456, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_in_delta 111.12, account.balance, 0.000001
  end
  
  test "an account of negative balance should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end
  
  test "an account with negative balance should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end

  test "an account with cvv longer than 4-digit should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123456", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end
  
  test "an account with cvv less than 3-digit should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "12", expiry_month: "1", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end

  test "an account with expiry month less than 1 should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "0", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end

  test "an account with expiry month greater than 12 should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "13", expiry_year: "2022", currency: "GBP")
    assert_not account.valid?
  end
  
  test "an account with expiry year earlier than 1900 should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "1899", currency: "GBP")
    assert_not account.valid?
  end

  test "an account with expiry year later than 2400 should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2401", currency: "GBP")
    assert_not account.valid?
  end

  test "an account with not-supported currency (\"ABC\") should be invalid" do
    user = users(:have_two_accounts)
    account = Account.new(user: user, balance: -10.00, account_number: "12345678", cvv: "123", expiry_month: "1", expiry_year: "2022", currency: "ABC")
    assert_not account.valid?
  end
end
