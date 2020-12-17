class AccountsController < ApplicationController
  before_action :check_ownership, only: :show

  def show
    @account = Account.find(params[:id])
    @transactions = @account.transactions
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  private

  def check_ownership
    redirect_to dashboard_path, notice: "This account is not yours!" if current_user != Account.find(params[:id]).user
  end
end
