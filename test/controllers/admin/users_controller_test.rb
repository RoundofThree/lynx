require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @users = User.all
  end


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

  test 'admin user should get user details by any user' do
    sign_in users(:admin)
    login_as_admin('abc')
    user = users(:have_no_accounts)
    get admin_user_url(user)
    assert_response :success
  end


  test 'admin user should get new' do
    sign_in users(:admin)
    login_as_admin('abc')
    get new_admin_user_url
    assert_response :success
  end

  test "admin user should be able to search and specify sorting criteria of users" do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_users_url, params: { sort_by: "last_sign_in_at" }
    assert_response :success
    get admin_users_url, params: { sort_by: "last_created_at" }
    assert_response :success
    get admin_users_url, params: { sort_by: "first_created_at" }
    assert_response :success
  end


  test "admin user should be able to create a user" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:have_one_account)
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

    test "admin user should be able to create a user with only required fields" do
        sign_in users(:admin)
        login_as_admin('abc')
        user = users(:have_one_account)
        assert_difference('User.count') do
          post admin_users_url, params: { user:
            { firstname: user.firstname, lastname: user.lastname,
              phone: user.phone, birth_date: "19991010",
              is_female: true, email: "a@q.com", password: "123456",
              password_confirmation: "123456" } }
        end
        assert_redirected_to [:admin, User.last]
      end

    test "create should fail if not all required params are filled" do
        sign_in users(:admin)
        login_as_admin('abc')
        assert_no_difference('User.count') do
          post admin_users_url, params: {user:{firstname: "hello"}}
        end
        assert_response :success
      end

    test "not admin user should not be able to create a user" do
          assert_no_difference('User.count') do
            post admin_users_url, params: {user:{firstname: "hello"}}
          end
          assert_response :missing
        end

    test 'admin user should get edit' do
          sign_in users(:admin)
          login_as_admin('abc')
          user = users(:have_one_account)
          get edit_admin_user_url(user)
          assert_response :success
        end

    test "admin user should be able to update user" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:have_one_account)
      patch admin_user_url(user), params: { user:
         { firstname: user.firstname, lastname: user.lastname,
            phone: user.phone, birth_date: "19991010", is_female: true,
             email: "a@q.com", password: "123456", password_confirmation: "123456",
             postcode:"N79AW", country:"UK",
             address_line_1:"a", address_line_2:"2" } }
      assert_redirected_to admin_user_url(user)
    end

    test "admin user should be able to update admin passphrase" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:admin)
      patch admin_user_url(user), params: { user:
         { firstname: user.firstname, lastname: user.lastname,
            phone: user.phone, birth_date: "19991010", is_female: true,
             email: "a@q.com", password: "123456", password_confirmation: "123456",
             postcode:"N79AW", country:"UK",
             address_line_1:"a", address_line_2:"2", admin_passphrase: "123456" } }
      assert_redirected_to admin_user_url(user)
    end

    test "update should success if required fields are filled" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:have_one_account)
      patch admin_user_url(user), params: { user:
         { firstname: user.firstname, lastname: user.lastname,
            phone: user.phone, birth_date: "19991010", is_female: true,
             email: "a@q.com", password: "123456", password_confirmation: "123456" } }
      assert_redirected_to admin_user_url(user)
    end

    test "update should fail if required fields are not filled" do
     sign_in users(:admin)
     login_as_admin('abc')
     user = users(:have_one_account)
     assert_no_difference 'User.count' do
     patch admin_user_url(user), params: { user:
        { firstname: user.firstname, lastname: user.lastname,
           phone: user.phone, birth_date: "19991010", is_female: true,
            email: "a@q.com", password: "12356", password_confirmation: "123456",
            postcode:"N79AW", country:"UK",
            address_line_1:"a"} }
          end
    assert_equal 'Failed to save changes.', flash[:error]
     assert_template :edit
   end

  test "not admin user should not be able to update an user" do
   user = users(:have_one_account)
   assert_no_difference 'User.count' do
   patch admin_user_url(user), params: { user:
      { firstname: user.firstname, lastname: user.lastname,
         phone: user.phone, birth_date: "19991010", is_female: true,
          email: "a@q.com", password: "123456", password_confirmation: "123456",
          postcode:"N79AW", country:"UK",
          address_line_1:"a"} }
        end
        assert_response :missing
 end

  test "admin user should be able to destroy any user" do
      sign_in users(:admin)
      login_as_admin('abc')
      user = users(:have_one_account)
      assert_difference('User.count', -1) do
        delete admin_user_url(user)
      end
      assert_redirected_to admin_users_url
  end

  test "not admin user should not be able to destroy any user" do
    user = users(:have_one_account)
    assert_no_difference('User.count') do
      delete admin_user_url(user)
    end
    assert_response :missing
  end
end
