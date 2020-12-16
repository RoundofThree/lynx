module DashboardHelper
  def total_balance
    accounts = Account.where(user: current_user.id)
    @total_balance = 0
    accounts.each do|account|
      @total_balance = account.balance + @total_balance
    end
    @total_balance
  end
end
