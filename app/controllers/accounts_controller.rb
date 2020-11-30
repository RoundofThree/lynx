class AccountsController < ApplicationController
  def show
    @account = Account.find(params[:id])
    @transactions = @account.transactions
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
