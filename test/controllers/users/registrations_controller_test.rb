require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # new tests 
  test "should get new" do 
    get new_user_registration_url
    assert_response :success
  end 

  # create tests 
  test "should create user" do
    assert_difference('User.count', 1) do 
      post user_registration_url, params: { user: { firstname: 'Nyx', lastname: 'Random', email: 'nyx@gmail.com', phone: "+447740271205",
                                          birth_date: "20011128", password: '1234567890',
                                          password_confirmation: "1234567890", postcode: "SE14XA", address_line_1: "354", address_line_2: "Majorca", 
                                          country: "Spain", is_female: true } }
    end 
    assert_redirected_to dashboard_path  # redirected to personal dashboard 
  end

end