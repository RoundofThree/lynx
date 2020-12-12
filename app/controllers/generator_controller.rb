class GeneratorController < ApplicationController
  def index
    @accounts = Account.where(:user => current_user.id)
    @myValue = "value"
  end

  def generate_transactions
    puts "print something"
    # @accounts.each do |account|
    #   matchingDealers = Dealer.where(:currency => account.currency)
    #   for i in 0..10
    #     dealer = Dealer.find(rand(matchingDealers.length))
    #     amount = rand(dealer.maximum) + dealer.minimun
    #     # account.transactions.create!();
    #   end
    # end
  end

  private 
  
  # Given an integer amount,
  # Returns a float amount with realistic decimal values 
  def authenticate_amount amount
    return amount + 0.5;
  end
end
