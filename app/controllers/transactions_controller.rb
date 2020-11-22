class TransactionsController < ApplicationController
  before_action :check_have_at_least_one_account

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @account = @transaction.payer_account
    begin 
      Account.transaction(@account, @transaction) do
        @account.substract_amount(@transaction.amount)  # lock the account balance?
        @transaction.save!
      end
      redirect_to @transaction, notice: 'Payment successfully made.'
    rescue ActiveRecord::RecordInvalid => invalid
      render 'new' # flash error?
    end
  end

  private

  def check_have_at_least_one_account
    if current_user.accounts.empty?
      redirect_to dashboard_path, notice: "You don't have any accounts yet!"
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :payer_account_id, :payee_account_number, :payee_fullname,
                                        :currency, :reference, :created_at)
  end

end
