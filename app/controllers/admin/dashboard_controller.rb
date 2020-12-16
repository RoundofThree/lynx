class Admin::DashboardController < Admin::ApplicationController
  def index
    @users = User.order('last_sign_in_at desc').limit(10)
    @accounts = Account.order('updated_at desc').limit(10)
    @transactions = Transaction.order('created_at desc').limit(10)
  end
end
