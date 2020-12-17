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
    user = users(:have_no_accounts)
    get admin_user_url(user)
    assert_response :success
  end

  test "admin user should be able to create a user" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:one)
      assert_difference('User.count') do
        post admin_users_url, params: { user:
          { firstname: user.firstname, lastname: user.lastname,
            phone: user.phone, birth_date: "19991010",
            is_female: true, email: "a@q.com", password: "123456",
            password_confirmation: "123456",postcode:"N79AW", country:"UK",
            address_line_1:"a", address_line_2:"2" } }
      end
      assert_redirected_to [:admin, User.last]
    end
end
