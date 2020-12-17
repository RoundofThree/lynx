require 'test_helper'

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # new
  test 'not logged in user should render 404 instead of the admin access form' do
    get admin_login_url
    assert_response :missing
  end

  test 'a user who is not admin should render 404 instead of the admin access form' do
    sign_in users(:have_one_account)
    get admin_login_url
    assert_response :missing
    sign_out :user
  end

  test 'an admin user should get the access form that prompts him/her for the passphrase' do
    sign_in users(:admin)
    get admin_login_url
    assert_response :success
    sign_out :user
  end

  # create
  test 'an admin with valid admin passphrase should be redirected to the admin dashboard' do
    sign_in users(:admin)
    login_as_admin('abc')
    assert_redirected_to admin_dashboard_url
    sign_out :user
  end

  test 'an admin with incorrect passphrase should not be able to access admin dashboard' do
    sign_in users(:admin)
    login_as_admin('bca')
    get admin_dashboard_url
    assert_response :missing
    sign_out :user
  end

  # destroy
  test 'an admin should not get the admin dashboard after logging out as admin' do
    sign_in users(:admin)
    login_as_admin('abc')
    logout_as_admin
    get admin_dashboard_url
    assert_response :missing
  end
end
