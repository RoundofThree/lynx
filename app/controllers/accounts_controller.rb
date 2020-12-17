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
    account = Account.find(params[:id])
    redirect_to dashboard_path, alert: 'This account is not yours!' if account.nil? || current_user != account.user
  end
end
