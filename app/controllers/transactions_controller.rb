class TransactionsController < ApplicationController
  # before_action :check_have_at_least_one_account
  before_action :require_permissions, only: :show

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @accounts = Account.all 
  end

  def create
    @transaction = Transaction.new(transaction_params)
    # find account 
    if params[:transaction][:payer_account_id]
      @account = Account.find(params[:transaction][:payer_account_id])
    else 
      redirect_to new_transaction_path, notice: "Select a valid account"
    end 
    @transaction.currency = @account.currency
    if @account.user_id == current_user.id && @transaction.save  
      # substract the balance 
      amount = params[:transaction][:amount]
      @account.balance = @account.balance - amount.to_d
      @account.save!
      redirect_to transaction_path(@transaction.id)
    else
      redirect_to new_transaction_path, notice: @transaction
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
