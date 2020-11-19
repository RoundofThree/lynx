class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u|
        u.permit(:firstname, :lastname, :email, :password, :phone, :birth_date, :is_female, :postcode, :address_line_1, :address_line_2, :country)
      end
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:email, :password, :current_password, :phone, :postcode, :address_line_1, :address_line_2, :country)
      end
    end 
end
