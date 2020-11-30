class TransactionsController < ApplicationController
  before_action :check_have_at_least_one_account
  before_action :require_permissions, only: :show

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    amount = params[:transaction]["amount"]
    if params[:transaction][:payer_account_id]
      @account = Account.find(params[:transaction][:payer_account_id])
    end 
    if @account && @account.user == current_user && @transaction.save  
      # substract the balance 
      @account.balance = @account.balance - amount.to_d
      @account.save 
      redirect_to dashboard_path
    else
      redirect_to new_transaction_path, notice: "Failed to process transaction"
    end
  end

  private

  def require_permissions
    if current_user != Transaction.find(params[:id]).payer_account.user 
      redirect_to dashboard_path, notice: "Invalid transaction id!"
    end 
  end 

  def check_have_at_least_one_account
    if current_user.accounts.empty?
      redirect_to dashboard_path, notice: "You don't have any accounts yet!"
    else 
      @accounts = current_user.accounts
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :payer_account_id, :payee_account_number, :payee_fullname,
                                        :currency, :reference)
  end

end
