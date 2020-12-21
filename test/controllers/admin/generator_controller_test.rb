require 'test_helper'

class Admin::GeneratorControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    login_as_admin('abc')
  end

  teardown do
    sign_out :user
  end

  test 'access generator without log in should get 404' do
    sign_out :user
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '1 month' }
    assert_response(404)
  end

  test 'access generator with user who is not admin should get 404' do
    sign_out :user
    sign_in users(:have_one_account)
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '1 month' }
    assert_response(404)
  end

  test 'access generator with incomplete parameters should be redirected to admin accounts' do
    post admin_generator_generate_transactions_url, params: { account: accounts(:one).id }
    assert_redirected_to admin_accounts_url
  end

  test 'generate 10 transactions for one account should increment the transactions count properly' do
    assert_difference('Transaction.count', 10) do
      post admin_generator_generate_transactions_url,
           params: { account: accounts(:one).id, how_many: 10, period: '3 months' }
    end
  end

  test 'generate 10 transactions for all accounts should increment the transactions count properly' do
    assert_difference('Transaction.count', Account.count * 10) do
      post admin_generator_generate_transactions_url, params: { account: 'All', how_many: 10, period: '1 month' }
    end
  end

  test 'generate transactions for recent month should create transactions with correct times' do
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '1 month' }
    new_transactions = Transaction.order('updated_at DESC').limit(10)
    earliest = new_transactions.min_by(&:created_at).created_at
    latest = new_transactions.max_by(&:created_at).created_at
    assert earliest >= 1.month.ago
    assert latest <= Time.now
  end

  test 'generate transactions for recent 3 months should create transactions with correct times' do
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '3 months' }
    new_transactions = Transaction.order('updated_at DESC').limit(10)
    earliest = new_transactions.min_by(&:created_at).created_at
    latest = new_transactions.max_by(&:created_at).created_at
    assert earliest >= 3.month.ago
    assert latest <= Time.now
  end

  test 'generate transactions for recent year should create transactions with correct times' do
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '1 year' }
    new_transactions = Transaction.order('updated_at DESC').limit(10)
    earliest = new_transactions.min_by(&:created_at).created_at
    latest = new_transactions.max_by(&:created_at).created_at
    assert earliest >= 1.year.ago
    assert latest <= Time.now
  end

  test 'generate transactions for recent 3 years should create transactions with correct times' do
    post admin_generator_generate_transactions_url,
         params: { account: accounts(:one).id, how_many: 10, period: '3 years' }
    new_transactions = Transaction.order('updated_at DESC').limit(10)
    earliest = new_transactions.min_by(&:created_at).created_at
    latest = new_transactions.max_by(&:created_at).created_at
    assert earliest >= 3.year.ago
    assert latest <= Time.now
  end
end
