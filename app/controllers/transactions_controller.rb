class TransactionsController < ApplicationController
  before_action :check_have_at_least_one_account
  before_action :require_permissions, only: :show
  before_action :check_amount, only: :create

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
  end

  def create
    @transaction = Transaction.new(transaction_params)
    # find account
    @account = Account.find(params[:transaction][:account_id]) unless params[:transaction][:account_id].blank?
    if @account.nil? || @account.user_id != current_user.id
      flash[:error] = 'Select a valid account.'
      redirect_to new_transaction_path
      return
    end
    @transaction.currency = @account.currency
    @transaction.amount = -@transaction.amount
    if @transaction.save
      # substract the balance
      amount = params[:transaction][:amount]
      @account.balance = @account.balance - amount.to_d

      if @account.save
        flash[:success] = "Payment success."
        redirect_to transaction_path(@transaction.id)
      else # if ever something goes wrong, rollback transaction
        @transaction.destroy
        flash[:alert] = "Payment failed, try again."
        redirect_to new_transaction_path
      end
    else
      flash[:error] = "Payment failed, try again."
      redirect_to new_transaction_path
    end
  end

  private

  def check_amount
    if transaction_params[:amount].to_d <= 0.0
      flash[:error] = 'Invalid amount'
      redirect_to new_transaction_path
    end
  end

  def require_permissions
    if current_user != Transaction.find(params[:id]).account.user
      flash[:error] = 'Invalid transaction id!'
      redirect_to dashboard_path
    end
  end

  def check_have_at_least_one_account
    if current_user.accounts.empty?
      flash[:error] = "You don't have any accounts yet!"
      redirect_to dashboard_path
    else
      @accounts = current_user.accounts
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :account_id, :dealer_account_number, :dealer_name, :reference)
  end
end
