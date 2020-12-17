require 'test_helper'

class Admin::StylesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # edit 
  test 'not logged in user should render 404' do
    get admin_styles_edit_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_styles_edit_url
    assert_response :missing
    sign_out :user
  end

  test 'admin user should get styles edit page' do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_styles_edit_url
    assert_response :success
    sign_out :user 
  end

  # update 
  test 'admin should be able to change footer links' do 
    sign_in users(:admin)
    login_as_admin('abc')
    current_style = styles(:current)
    new_home_links_1 = "Hello, World"
    new_home_links_2 = "Kibana   , ElasticSearch"
    assert_no_difference('Style.count') do 
      put admin_styles_url, params: { style: { home_links_1: new_home_links_1, home_links_2: new_home_links_2} }
    end 
    assert_redirected_to admin_styles_edit_url
    current_style.reload 
    assert_equal ["Hello", "World"], current_style.home_links_1
    assert_equal ["Kibana", "ElasticSearch"], current_style.home_links_2
    sign_out :user 
  end

  test 'update style to have a blank bank name should fail' do 
    sign_in users(:admin)
    login_as_admin("abc")
    current_style = styles(:current)
    put admin_styles_url, params: { style: { bank_name: "" } }
    assert_redirected_to admin_styles_edit_url 
    assert_not_equal "", current_style.bank_name
  end 

end
