# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /users/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /users/password
  def update
    super
  end

  protected

  def after_resetting_password_path_for(user)
    super(user)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(user)
    super(user)
  end
end
