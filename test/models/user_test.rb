require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "the name of user should be upcase after create" do
    user = users(:have_two_accounts)
    assert_same "Zhuo Zhuo Ying", user.firstname
    assert_same  "ZHUO YING", user.firstname

    assert_same "Jiang Li", user.lastname
    assert_not_same "Jiang Li", user.lastname

  end

  test "user should have 0 accounts we after create" do
  user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date:"2001-11-15")
  assert_equal 0,user.accounts.size
  end

  test "user should contain 2 accounts when we use user with 2 accounts" do
  user = users(:have_two_accounts)
  assert_equal 2, user.accounts.size
  end

  test "user whose age is smaller than 18 is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date:"2009-11-15")
    assert_not user.valid?
  end

  test "user without firstname is invalid" do
    user = User.new(lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date:"2001-11-15")
    assert_not user.valid?
  end

  test "user without lastname is invalid" do
    user = User.new(firstname: "tao", email: "huangtao@abc.com" , phone: 13756181581, birth_date:"2001-11-15")
    assert_not user.valid?
  end

  test "user without email is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", phone: 13756181581, birth_date:"2001-11-15")
    assert_not user.valid?
  end

  test "user with invalid email format should not pass validation" do
    user = User.new(firstname: "tao", lastname: "huang", email: "1234", phone: 13756181581, birth_date:"2001-11-15")
    assert_not user.valid?
  end

  test "user without birth date is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581)
    assert_not user.valid?
  end

  test "user without phone is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com")
    assert_not user.valid?
  end



# todo
  test "valid" do
    user = users(:have_no_accounts)
    assert user.valid?

  end

end
