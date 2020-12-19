require 'test_helper'

class Admin::DealersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  test 'not logged in user should render 404' do
    get admin_dealers_url
    assert_response :missing
  end

  test 'not admin user should render 404' do
    sign_in users(:have_one_account)
    get admin_dealers_url
    assert_response :missing
    sign_out :user
  end

  test "admin user should get dealers list"do
    sign_in users(:admin)
    login_as_admin('abc')
    get admin_dealers_url
    assert_response :success
  end

  test "admin user should be able to view information of a dealer"do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = dealers(:one)
    get admin_dealers_url(dealer)
    assert_response :success
  end

  test "admin user should get new"do
    sign_in users(:admin)
    login_as_admin('abc')
    get new_admin_dealer_url
    assert_response :success
  end

  test "admin user should get edit"do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = dealers(:one)
    get edit_admin_dealer_url(dealer)
    assert_response :success
  end

  test "admin user should be able to create a dealer"do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = Dealer.new(name:"sass", account_number:"12345678901234",
    min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD")
    assert_difference('Dealer.count') do
      post admin_dealers_url, params: { dealer: dealer.attributes}
    end
    assert_redirected_to [:admin, Dealer.last]
  end

  test "create should fail if required params are not filled"do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = Dealer.new(name:"sass",
    min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD")
    assert_no_difference('Dealer.count') do
      post admin_dealers_url, params: { dealer: dealer.attributes}
    end
    assert_equal 'Error in creating dealer.', flash[:error]
     assert_template :new
  end

  test "admin user should be able to update a dealer"do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = dealers(:one)
    patch admin_dealer_url(dealer), params: {
      dealer:{ name:"helen", account_number:"19345678901234",
      min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD"
      }}
    assert_redirected_to [:admin, Dealer.last]
  end

  test "update should fail if account number is not 14 characters "do
    sign_in users(:admin)
    login_as_admin('abc')
    dealer = dealers(:one)
    patch admin_dealer_url(dealer), params: {
      dealer:{ name:"helen", account_number:"19301234",
      min_amount:"2",max_amount:"20", frequency:"30", is_vendor:true, currency:"USD"
      }}
      assert_equal 'Failed to save changes.', flash[:error]
     assert_template :edit
  end

    test "admin user should be able to destroy any user" do
      sign_in users(:admin)
      login_as_admin('abc')
      dealer = dealers(:one)
      assert_difference('Dealer.count', -1) do
          delete admin_dealer_url(dealer)
      end
      assert_redirected_to admin_dealers_url
    end


end
