class GeneratorController < ApplicationController
  def index
    @accounts = Account.where(:user => current_user.id)
  end

  def generate_transactions
    @accounts = Account.where(:user => current_user.id)
    @accounts.each do |account|
      matchingDealers = Dealer.where(:currency => account.currency)
      for i in 0...10
        dealer = matchingDealers[rand(matchingDealers.length)]
        amount = rand(dealer.max_amount) + dealer.min_amount
        time = rand((DateTime.now - 3.months)..DateTime.now)
        account.transactions.create!(
          account: account, 
          dealer_account_number: dealer.account_number,
          dealer_name: dealer.name,
          amount: amount,
          currency: account.currency
          );
      end
    end
  end

  private 
  
  # Given an integer amount,
  # Returns a float amount with realistic decimal values 
  def authenticate_amount amount
    return amount + 0.5;
  end
end
