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

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/accounts/1
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/accounts/1
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to admin_transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:all)
    end
end
