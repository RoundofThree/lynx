class AccountsController < ApplicationController
  before_action :check_ownership, only: :show

  def show
    @account = Account.find(params[:id])
    @transactions = @account.transactions
  end

  private

  def check_ownership
    account = Account.find(params[:id])
    if account.nil? || current_user != account.user
      flash[:error] = 'This account is not yours!'
      redirect_to dashboard_path
    end
  end
end
