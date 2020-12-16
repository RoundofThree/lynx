module DashboardHelper

  def total_balance_EUR
    accounts = Account.where(user: current_user.id)
    @total_balance_EUR = 0
    accounts.each do|account|
      if account.currency == "EUR"
      @total_balance_EUR = account.balance + @total_balance_EUR
    end
    end
    @total_balance_EUR
  end

  def total_balance_USD
    accounts = Account.where(user: current_user.id)
    @total_balance_USD = 0
    accounts.each do|account|
      if account.currency == "USD"
      @total_balance_USD = account.balance + @total_balance_USD
    end
    end
    @total_balance_USD
  end

  def total_balance_GBP
    accounts = Account.where(user: current_user.id)
    @total_balance_GBP = 0
    accounts.each do|account|
      if account.currency == "GBP"
      @total_balance_GBP = account.balance + @total_balance_GBP
    end
    end
    @total_balance_GBP
  end
end
