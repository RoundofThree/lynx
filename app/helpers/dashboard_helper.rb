module DashboardHelper
  def total_balance_EUR
    accounts = Account.where(user: current_user.id)
    @total_balance_EUR = 0
    accounts.each do |account|
      @total_balance_EUR = account.balance + @total_balance_EUR if account.currency == 'EUR'
    end
    @total_balance_EUR
  end

  def total_balance_USD
    accounts = Account.where(user: current_user.id)
    @total_balance_USD = 0
    accounts.each do |account|
      @total_balance_USD = account.balance + @total_balance_USD if account.currency == 'USD'
    end
    @total_balance_USD
  end

  def total_balance_GBP
    accounts = Account.where(user: current_user.id)
    @total_balance_GBP = 0
    accounts.each do |account|
      @total_balance_GBP = account.balance + @total_balance_GBP if account.currency == 'GBP'
    end
    @total_balance_GBP
  end
end
