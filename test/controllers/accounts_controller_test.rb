require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get accounts_show_url
    assert_response :success
  end

  test "should get new" do
    get accounts_new_url
    assert_response :success
  end

  test "should get create" do
    get accounts_create_url
    assert_response :success
  end

  test "should get edit" do
    get accounts_edit_url
    assert_response :success
  end

  test "should get update" do
    get accounts_update_url
    assert_response :success
  end

end
