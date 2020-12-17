class TransactionsController < ApplicationController
  before_action :check_have_at_least_one_account
  before_action :require_permissions, only: :show
  before_action :check_amount, only: :create

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
    @account = Account.find(params[:transaction][:account_id]) unless params[:transaction][:account_id].blank?
    if @account.nil?
      redirect_to new_transaction_path, error: 'Select a valid account.'
      return
    end
    @transaction.currency = @account.currency
    @transaction.amount = -@transaction.amount
    if @account.user_id == current_user.id && @transaction.save
      # substract the balance
      amount = params[:transaction][:amount]
      @account.balance = @account.balance - amount.to_d
      @account.save!
      redirect_to transaction_path(@transaction.id), success: "Payment success."
    else
      redirect_to new_transaction_path, error: "Payment failed, try again. "
    end
  end

  private

  def check_amount
    redirect_to new_transaction_path, error: 'Invalid amount' if transaction_params[:amount].to_d <= 0.0
  end

  def require_permissions
    if current_user != Transaction.find(params[:id]).account.user
      redirect_to dashboard_path, error: 'Invalid transaction id!'
    end
  end

  def check_have_at_least_one_account
    if current_user.accounts.empty?
      redirect_to dashboard_path, alert: "You don't have any accounts yet!"
    else
      @accounts = current_user.accounts
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :account_id, :dealer_account_number, :dealer_name,
                                        :currency, :reference)
  end
end
