module Admin
  class ApplicationController < ApplicationController
    include Admin::SessionsHelper

    before_action :user_is_logged_in_admin?
    skip_before_action :authenticate_user!, raise: false

    def user_is_logged_in_admin?
      render_404 unless current_user && current_user.admin && admin_logged_in
    end

    private

    def render_404
      # raise ActionController::RoutingError.new('Not Found')
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end
end
