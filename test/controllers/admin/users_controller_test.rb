require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    login_as_admin('abc')
  end

  teardown do
    sign_out :user
  end

  # index tests
  test 'not logged in user should render 404' do
    sign_out :user
    get admin_users_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_out :user
    sign_in users(:have_one_account)
    get admin_users_url
    assert_response :missing
    sign_out :user
  end

  test 'admin user should get users list' do
    get admin_users_url
    assert_response :success
  end

  test 'admin user should get users list in xlsx format' do
    get admin_users_url(format: 'xlsx')
    assert_response :success
  end

  # searching and sorting tests
  test 'admin user should be able to search and specify sorting criteria of users' do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_users_url, params: { sort_by: 'last_sign_in_at' }
    assert_response :success
    get admin_users_url, params: { sort_by: 'last_created_at' }
    assert_response :success
    get admin_users_url, params: { sort_by: 'first_created_at' }
    assert_response :success
  end

  # show tests
  test 'admin user should get user details by any user' do
    user = users(:have_no_accounts)
    get admin_user_url(user)
    assert_response :success
  end

  # new tests
  test 'admin user should get new' do
    get new_admin_user_url
    assert_response :success
  end

  # create tests
  test 'admin user should be able to create a user' do
    user = users(:have_one_account)
    assert_difference('User.count', 1) do
      post admin_users_url, params: { user:
        { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: '19991010',
          is_female: true, email: 'a@q.com', password: '123456',
          password_confirmation: '123456', postcode: 'N79AW', country: 'UK',
          address_line_1: 'a', address_line_2: '2' } }
    end
    assert_redirected_to [:admin, User.last]
  end

  test 'admin user should be able to create a user with only required fields' do
    user = users(:have_one_account)
    assert_difference('User.count') do
      post admin_users_url, params: { user:
        { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: '19991010',
          is_female: true, email: 'a@q.com', password: '123456',
          password_confirmation: '123456' } }
    end
    assert_redirected_to [:admin, User.last]
  end

  test 'create should fail if not all required params are filled' do
    assert_no_difference('User.count') do
      post admin_users_url, params: { user: { firstname: 'hello' } }
    end
    assert_response :success
  end

  test 'not admin user should not be able to create a user' do
    sign_out :user
    sign_in users(:have_one_account)
    assert_no_difference('User.count') do
      post admin_users_url, params: { user: { firstname: 'hello' } }
    end
    assert_response :missing
  end

  # edit tests
  test 'admin user should get edit' do
    user = users(:have_one_account)
    get edit_admin_user_url(user)
    assert_response :success
  end

  # update tests
  test 'admin user should be able to update user' do
    user = users(:have_one_account)
    patch admin_user_url(user), params: { user:
        { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: '19991010', is_female: true,
          email: 'outt@q.com', password: '123456', password_confirmation: '123456',
          postcode: 'N79AW', country: 'UK',
          address_line_1: 'a', address_line_2: '2' } }
    user.reload
    assert_equal user.email, 'outt@q.com'
    assert_redirected_to admin_user_url(user)
  end

  test 'admin user should be able to update admin passphrase' do
    user = users(:admin)
    patch admin_user_url(user), params: { user:
        { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: '19991010', is_female: true,
          email: 'a@q.com', password: '123456', password_confirmation: '123456',
          postcode: 'N79AW', country: 'UK',
          address_line_1: 'a', address_line_2: '2', admin_passphrase: 'pass' } }
    assert_equal user.admin_passphrase_digest, 'ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad'
    assert_redirected_to admin_user_url(user)
  end

  test 'update should fail if required fields are not filled' do
    user = users(:have_one_account)
    assert_no_difference 'User.count' do
      patch admin_user_url(user), params: { user:
        { firstname: 'andy', lastname: user.lastname,
          phone: user.phone, birth_date: '19991010', is_female: true,
          email: 'a@q.com', password: '12356', password_confirmation: '123456',
          postcode: 'N79AW', country: 'UK',
          address_line_1: 'a' } }
    end
    user.reload
    assert_not_equal user.firstname, 'andy'
    assert_template :edit
  end

  test 'not admin user should not be able to update an user' do
    sign_out :user
    user = users(:have_one_account)
    assert_no_difference 'User.count' do
      patch admin_user_url(user), params: { user:
        { firstname: user.firstname, lastname: user.lastname,
          phone: user.phone, birth_date: '19991010', is_female: true,
          email: 'a@q.com', password: '123456', password_confirmation: '123456',
          postcode: 'N79AW', country: 'UK',
          address_line_1: 'a' } }
    end
    assert_response :missing
  end

  test 'admin user should be able to destroy any user' do
    user = users(:have_one_account)
    assert_difference('User.count', -1) do
      delete admin_user_url(user)
    end
    assert_redirected_to admin_users_url
  end

  test 'not admin user should not be able to destroy any user' do
    sign_out :user
    user = users(:have_one_account)
    assert_no_difference('User.count') do
      delete admin_user_url(user)
    end
    assert_response :missing
  end
end
