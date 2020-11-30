class AccountsController < ApplicationController
  def show
    account = Account.find(params[:id])
    @account_number = account.account_number
    @balance = account.balance
    @currency = account.currency
    
    @transactions = account.transactions
    
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
