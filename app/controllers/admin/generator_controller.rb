class Admin::GeneratorController < ApplicationController
  # POST
  def generate_transactions
    accounts = params[:account].eql?("All") ? 
    Account.all : Account.where(:id => params[:account])
    accounts.each do |account|
      matching_dealers = Dealer.where(:currency => account.currency)
      for i in 0...10
        dealer = get_weighted_random_dealer matching_dealers
        amount = -(rand(dealer.max_amount) + dealer.min_amount)
        time = rand((DateTime.now - 3.months)..DateTime.now)
        account.transactions.create!(
          account: account, 
          dealer_account_number: dealer.account_number,
          dealer_name: dealer.name,
          amount: amount,
          currency: account.currency,
          created_at: time
          );
      end
    end
  end
  
  private

  # Given an array of dealers.
  # Returns a random dealer weighted by frequency.
  def get_weighted_random_dealer dealers
    cum_frequency = dealers.reduce(0) {|sum, dealer| sum + dealer.frequency}
    target = rand(1..cum_frequency)
    dealers.each do |dealer|
      return dealer if target <= dealer.frequency
      target -= dealer.frequency
    end
  end

  # Given an integer amount.
  # Returns a float amount with realistic decimal values.
  def authenticate_amount amount
    return amount + 0.5;
  end
end