class HomeController < ApplicationController
  # no need to login
  skip_before_action :authenticate_user!
  
  def index
  end
end
