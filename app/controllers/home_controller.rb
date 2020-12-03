class HomeController < ApplicationController
  # no need to login
  skip_before_action :authenticate_user!, raise: false
  before_action :redirect_logged_user, if: -> { current_user.present? }

  def index
  end

  protected

  def redirect_logged_user
    redirect_to(dashboard_path)
  end
end
