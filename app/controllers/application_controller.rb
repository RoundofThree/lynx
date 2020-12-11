class ApplicationController < ActionController::Base
  include StyleHelper  # for custom style 

  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
  helper_method :user_is_admin?

  def user_is_admin?
    unless current_user && current_user.admin
      render_404
    end
  end

  def render_404
    # raise ActionController::RoutingError.new('Not Found')
    render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found
  end

end
