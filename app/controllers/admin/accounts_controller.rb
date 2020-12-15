class Admin::AccountsController < Admin::ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  # GET /admin/accounts (or .json)
  def index
    @accounts = Account.search(params[:search]) # maybe search by name of user?
    sort_accounts if !@accounts.empty?
  end

  # sort by created_at, updated_at 
  def sort_accounts
    if params[:sort_by].present?
      criteria = params[:sort_by]
      if criteria == "last_created_at"
        @accounts = @accounts.order("created_at desc")
      elsif criteria == "first_created_at"
        @accounts = @accounts.order("created_at asc")
      else 
        @accounts = @accounts.order("updated_at desc")
      end 
    else # default sorting 
      @accounts = @accounts.order("updated_at desc")
    end 
  end 

  # GET /admin/accounts/1
  def show
    @user = @account.user 
  end

  # GET /admin/accounts/new
  def new
    @account = Account.new
  end

  # GET /admin/accounts/1/edit
  def edit
  end

  # POST /admin/accounts
  def create
    @account = Account.new(account_params)
      if @account.save
        redirect_to admin_account_path(@account), notice: 'Account was successfully created.'
      else
        flash[:error] = "Error in creating account."
        render :new
      end
  end

  # PATCH/PUT /admin/accounts/1
  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      flash[:error] = "Failed to save changes."
      render :edit 
    end
  end

  # DELETE /admin/accounts/1
  def destroy
    @account.destroy
    redirect_to admin_accounts_url, notice: 'Account was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:balance, :account_number, :cvv, :expiry_date, :currency)
  end
end
