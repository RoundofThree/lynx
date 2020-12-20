require 'test_helper'

class Admin::DealersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do 
    sign_in users(:admin)
    login_as_admin("abc")
  end 

  teardown do 
    sign_out :user  
  end 

  # index tests 
  test 'not logged in user should render 404' do
    sign_out :user 
    get admin_dealers_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_out :user 
    sign_in users(:have_one_account)
    get admin_dealers_url
    assert_response :missing
  end

  test "admin user should get dealers list"do
    get admin_dealers_url
    assert_response :success
  end

  # show tests 
  test "admin user should be able to view information of a dealer"do
    dealer = dealers(:one)
    get admin_dealers_url(dealer)
    assert_response :success
  end

  # new tests
  test "admin user should get new"do
    get new_admin_dealer_url
    assert_response :success
  end

  # edit tests 
  test "admin user should get edit"do
    dealer = dealers(:one)
    get edit_admin_dealer_url(dealer)
    assert_response :success
  end

  # create tests 
  test "admin user should be able to create a dealer"do
    dealer = Dealer.new(name:"sass", account_number:"12345678901234",
    min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD")
    assert_difference('Dealer.count') do
      post admin_dealers_url, params: { dealer: dealer.attributes}
    end
    assert_redirected_to [:admin, Dealer.last]
  end

  test "create should fail if required params are not filled"do
    dealer = Dealer.new(name:"sass",
    min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD")
    assert_no_difference('Dealer.count') do
      post admin_dealers_url, params: { dealer: dealer.attributes}
    end
    assert_equal 'Error in creating dealer.', flash[:error]
     assert_template :new
  end

  # update tests
  test "admin user should be able to update a dealer"do
    dealer = dealers(:one)
    patch admin_dealer_url(dealer), params: {
      dealer:{ name:"helen", account_number:"19345678901234",
      min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD"
      }}
    assert_redirected_to [:admin, Dealer.last]
  end

  test "update should fail if account number is not 14 characters "do
    dealer = dealers(:one)
    patch admin_dealer_url(dealer), params: {
      dealer:{ name:"helen", account_number:"19301234",
      min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD"
      }}
      assert_equal 'Failed to save changes.', flash[:error]
     assert_template :edit
  end

  # destroy tests 
    test "admin user should be able to destroy any user" do
      dealer = dealers(:one)
      assert_difference('Dealer.count', -1) do
          delete admin_dealer_url(dealer)
      end
      assert_redirected_to admin_dealers_url
    end

end
