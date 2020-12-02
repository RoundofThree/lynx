class Admin::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!
  before_action :user_is_admin?
  # GET /admin/transactions (or .json)
  def index
    @transactions = Transaction.order("created_at desc")
  end

  # GET /admin/accounts/1
  def show
    @payer_account = @transaction.payer_account
    @payer = @payer_account.user
  end

  # GET /admin/accounts/new
  def new
    @transaction = Transaction.new
  end

  # GET /admin/accounts/1/edit
  def edit
  end

  # POST /admin/accounts
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save 
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else 
      render :new # flash errors 
    end
    end
  end

  # PATCH/PUT /admin/accounts/1
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        redirect_to @transaction, notice: 'Transaction was successfully updated.'
      else
        render :edit # flash errors
      end
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
      params.require(:transaction).permit(:all)
    end
end
