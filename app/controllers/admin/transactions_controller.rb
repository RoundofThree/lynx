class Admin::TransactionsController < Admin::ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  # GET /admin/transactions (or .json)
  def index
    @transactions = Transaction.search(params[:search])
    sort_transactions if !@transactions.empty?
  end

  # sort by created_at, amount
  def sort_transactions 
    if params[:sort_by].present?
      criteria = params[:sort_by]
      if criteria == "last_created_at"
        @transactions = @transactions.order("created_at desc")
      elsif criteria == "first_created_at"
        @transactions = @transactions.order("created_at asc")
      else 
        @transactions = @transactions.order("amount asc")
      end
    else # default sorting 
      @transactions = @transactions.order("amount asc")
    end   
  end 

  # GET /admin/accounts/1
  def show
    @account = @transaction.account
    @payer = @account.user
  end

  # GET /admin/accounts/new
  def new
    @transaction = Transaction.new
  end

  # GET /admin/accounts/1/edit
  def edit; end

  # POST /admin/accounts
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      render :new # flash errors
    end
  end

  # PATCH/PUT /admin/accounts/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit # flash errors
    end
  end

  # DELETE /admin/accounts/1
  def destroy
    @transaction.destroy
    redirect_to admin_transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :currency, :dealer_account_number, 
                                        :dealer_name, :reference, :created_at)
  end
end
