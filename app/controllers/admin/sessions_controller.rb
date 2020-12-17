class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :user_is_logged_in_admin?
  before_action :user_is_admin? # ensure current_user is admin
  before_action :redirect_logged_admin, only: %i[new create]

  # GET /admin/login
  def new; end

  # POST /admin/login
  def create
    if current_user.authenticate_admin_passphrase(params[:admin_passphrase])
      admin_login
      redirect_to admin_dashboard_path, notice: 'Logged in as admin.'
    else
      flash.now[:alert] = 'Invalid'
      render :new
    end
  end

  # DELETE /admin/logout
  def destroy
    admin_logout
    redirect_to dashboard_path, notice: 'Logged out as admin.'
  end

  private

  def redirect_logged_admin
    redirect_to admin_dashboard_path if admin_logged_in && current_user && current_user.admin
  end

  def user_is_admin?
    render_404 unless current_user && current_user.admin
  end
end
