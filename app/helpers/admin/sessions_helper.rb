module Admin::SessionsHelper
  # safe?
  def admin_login
    session[:admin] = 'True'
  end

  def admin_logout
    session[:admin] = nil
  end

  def admin_logged_in
    session[:admin] == 'True'
  end
end
