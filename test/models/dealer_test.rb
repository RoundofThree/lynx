require 'test_helper'

class DealerTest < ActiveSupport::TestCase
  test 'a dealer with proper attributes should be valid' do
    dealer = Dealer.new(currency: '32', name: 'Burger King', account_number: '12110987654321', min_amount: 2,
                        max_amount: 20, frequency: 10, is_vendor: true)
    assert dealer.valid?
  end

  test 'a dealer with max amount less than mix amount should be invalid' do
    dealer = Dealer.new(currency: '32', name: 'Burger King', account_number: '12110987654321', min_amount: 2,
                        max_amount: 1, frequency: 10, is_vendor: true)
    assert_not dealer.valid?
  end
end
