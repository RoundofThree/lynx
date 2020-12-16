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

  test "admin user should get users list" do
    sign_in users(:admin)
    login_as_admin("abc")
    get admin_users_url
    assert_response :success
  end

  test "admin user should get user details by any user" do
    sign_in users(:admin)
    login_as_admin("abc")
    user = users(:have_one_account)
    get admin_user_url(user)
    assert_response :success
  end

  test "admin user should create user" do
    sign_in users(:admin)
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

  test "admin user should be able to edit and update user" do
    sign_in users(:admin)
    user = users(:one)
    patch admin_user_url(user), params: { user:
       { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: "19991010", is_female: true,
           email: "a@q.com", password: "123456", password_confirmation: "123456",
           postcode:"N79AW", country:"UK",
           address_line_1:"a", address_line_2:"2" } }
    assert_redirected_to [:admin, User.last]
  end

  test "edit should fail if required fields are not filled" do
    sign_in users(:admin)
    user = users(:one)
    assert_no_difference 'User.count' do
    patch admin_user_url(user), params: { user:
       { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: "19991010", is_female: true,
           email: "a@q.com", password: "123456", password_confirmation: "123456",
           postcode:"N79AW", country:"UK",
           address_line_1:"a"} }
         end
    assert_redirected_to [:admin, User.last]
  end


  # test destroy 
  test "admin user should be able to destroy any user" do 
    sign_in users(:admin) 
    login_as_admin("abc")

    user = users(:have_one_account)
    assert_difference('User.count', -1) do
      delete admin_user_url(user)
    end
    assert_redirected_to admin_users_url
  end

end
