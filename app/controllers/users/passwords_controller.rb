# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/new
  def new
    super
  end

  # POST /users/password
  def create
    # super
    redirect_to new_user_session_url, notice: "You will receive an email with instructions on how to reset your password in a few minutes."
  end

  # GET /users/password/edit?reset_password_token=abcdef
  # def edit
  #  super
  # end

  # PUT /users/password
  # def update
  #   super
  # end

  protected

  # def after_resetting_password_path_for(user)
  #   super(user)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(user)
  #   super(user)
  # end
end
