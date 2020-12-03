module Admin
  class ApplicationController < ActionController::Base
    skip_before_action :authenticate_user!, raise: false
    before_action :user_is_admin?
  end
end
