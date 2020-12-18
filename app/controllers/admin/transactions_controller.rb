class Admin::TransactionsController < Admin::ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  # GET /admin/transactions
  def index
    @transactions = Transaction.search(params[:search])
    sort_transactions unless @transactions.empty?
  end

  # sort by created_at, amount
  def sort_transactions
    if params[:sort_by].present?
      criteria = params[:sort_by]
      @transactions = if criteria == 'last_created_at'
                        @transactions.order('created_at desc')
                      elsif criteria == 'first_created_at'
                        @transactions.order('created_at asc')
                      else
                        @transactions.order('amount asc')
                      end
    else # default sorting
      @transactions = @transactions.order('amount asc')
    end
  end

  # GET /admin/transactions/1
  def show
    @account = @transaction.account
    @payer = @account.user
  end

  # GET /admin/transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /admin/transactions/1/edit
  def edit; end

  # POST /admin/transactions
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to admin_transaction_path(@transaction), notice: 'Transaction was successfully created.'
    else
      flash.now[:error] = "Error in creating transaction."
      render :new
    end
  end

  # PATCH/PUT /admin/transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to admin_transaction_path(@transaction), notice: 'Transaction was successfully updated.'
    else
      flash.now[:error] = "Error in updating transaction."
      render :edit
    end
  end

  # DELETE /admin/transactions/1
  def destroy
    @transaction.destroy
    redirect_to admin_transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:account_id,:amount, :currency, :dealer_account_number,
                                        :dealer_name, :reference, :created_at)
  end
  
end
