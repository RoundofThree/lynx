class Admin::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, raise: false
  before_action :user_is_admin?
  # GET /admin/accounts (or .json)
  def index
    @accounts = Account.order("updated_at desc")
  end

  # GET /admin/accounts/1
  def show
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

    respond_to do |format|
      if @account.save
        format.html { redirect_to admin_account_path(@account), notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: admin_account_path(@account) }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/accounts/1
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
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
      params.permit(:all)
    end
end
