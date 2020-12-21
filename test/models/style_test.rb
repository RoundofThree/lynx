require 'test_helper'

class StyleTest < ActiveSupport::TestCase
  test "create a new style when there is already one should fail" do 
    style = Style.new(bank_name: "Lynx") 
    assert_not style.save
  end

  test "style that has a bank name with length between 1 and 20 characters should be valid" do 
    # clear the styles table 
    styles(:current).destroy 
    style = Style.new(bank_name: "Lynx")
    assert style.save
  end 
end
