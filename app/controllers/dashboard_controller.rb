class DashboardController < ApplicationController
  def index
    @accounts = Account.where(user: current_user.id)
  end
end
