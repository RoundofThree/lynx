require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'not logged in user should render 404' do
    get admin_users_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_users_url
    assert_response :missing
    sign_out :user
  end

  test 'admin user should get users list' do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_users_url
    assert_response :success
  end

  # test show
  test 'admin user should get user details by any user' do
    sign_in users(:admin)
    login_as_admin('abc')
    user = users(:have_one_account)
    get admin_user_url(user)
    assert_response :success
  end

  # test new (Yuxin)

  # test create (Yuxin)

  # test edit (Yuxin)

  # test update (Yuxin)

  # test destroy
  test 'admin user should be able to destroy any user' do
    sign_in users(:admin)
    login_as_admin('abc')
    user = users(:have_one_account)
    assert_difference('User.count', -1) do
      delete admin_user_url(user)
    end
    assert_redirected_to admin_users_url
  end
end
