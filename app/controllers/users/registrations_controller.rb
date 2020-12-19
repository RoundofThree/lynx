# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /users/sign_up
  def new
    super
  end

  # POST /users
  def create
    super
  end

  # GET /users/edit
  # def edit
  #  super
  # end

  # PUT /user
  # def update
  #   super
  # end

  # DELETE /user
  # def destroy
  #   super
  # end

  # GET /user/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:firstname, :lastname, :email, :password, :phone, :birth_date, :is_female, :postcode, :address_line_1,
               :address_line_2, :country)
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #  devise_parameter_sanitizer.permit(:account_update) do |u|
  #     u.permit(:email, :password, :current_password, :phone, :postcode, :address_line_1, :address_line_2, :country)
  #   end
  # end

  # The path used after sign up.
  def after_sign_up_path_for(user)
    dashboard_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(user)
  #   super(user)
  # end
end
