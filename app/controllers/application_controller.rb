class ApplicationController < ActionController::Base
  include ApplicationHelper
  include StyleHelper  # for custom style

  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
end
