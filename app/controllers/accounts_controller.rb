class AccountsController < ApplicationController
  def show
    account = Account.find(params[:id])
    id = params[:id]
    @balance = account.balance
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
