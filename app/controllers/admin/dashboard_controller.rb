class Admin::DashboardController < ApplicationController
  def index 
    @users = User.all 
    @accounts = Account.all
    @transactions = Transaction.all 
  end 
end
