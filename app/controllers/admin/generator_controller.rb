class Admin::GeneratorController < Admin::ApplicationController
  before_action :all_params_present?

  # Generates some transactions by the given parameters
  def generate_transactions
    accounts = if params[:account].eql?('All')
                 Account.all
               else
                 Account.where(id: params[:account])
               end
    accounts.each do |account|
      matching_dealers = Dealer.where(currency: account.currency)
      (0...params[:how_many].to_i).each do |_i|
        dealer = get_weighted_random_dealer matching_dealers
        account.transactions.create!(
          account: account,
          dealer_account_number: dealer.account_number,
          dealer_name: dealer.name,
          amount: get_random_amount(dealer),
          currency: account.currency,
          created_at: get_random_time(params[:period])
        )
      end
    end
  end

  private

  # Given an array of dealers.
  # Returns a random dealer weighted by frequency.
  def get_weighted_random_dealer(dealers)
    cum_frequency = dealers.reduce(0) { |sum, dealer| sum + dealer.frequency }
    target = rand(1..cum_frequency)
    dealers.each do |dealer|
      return dealer if target <= dealer.frequency

      target -= dealer.frequency
    end
  end

  # Returns a random amount for a dealer.
  # If the dealer is a vendor, the amount is always negative.
  # Else there is a chance that the amount is positive.
  def get_random_amount(dealer)
    amount = rand(dealer.max_amount) + dealer.min_amount
    if dealer.is_vendor
      -amount
    else
      rand > 0.5 ? amount : -amount
    end
  end

  # Returns a random time for the given period option.
  def get_random_time(option)
    case option
    when '1 month'
      rand(1.month.ago..Time.now)
    when '3 months'
      rand(3.month.ago..Time.now)
    when '1 year'
      rand(1.year.ago..Time.now)
    when '3 years'
      rand(3.year.ago..Time.now)
    end
  end

  # Check if all parameters are present, if not, redirect to admin accounts page
  def all_params_present?
    unless params[:account] && params[:period] && params[:how_many]
      flash[:error] = 'Please enter all the details to automatically generate transactions.'
      redirect_to admin_accounts_url
    end
  end
end
