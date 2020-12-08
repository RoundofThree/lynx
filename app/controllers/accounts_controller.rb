class AccountsController < ApplicationController
  before_action :check_ownership, only: :show

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
  
  private

  def check_ownership
    if current_user != Transaction.find(params[:id]).payer_account.user 
      redirect_to dashboard_path, notice: "This account is not yours!"
    end 
  end
end
