require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the name of user should be in uppercase after save" do
    user = User.create!(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_equal user.firstname, "TAO"
    assert_not_equal  user.firstname, "tao"

    assert_equal user.lastname, "HUANG"
    assert_not_equal user.lastname, "huang"
  end

  test "user should have 0 accounts after create" do
    user = User.create!(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_equal 0, user.accounts.size
  end

  test "user should contain 2 accounts when we use user with 2 accounts" do
    user = users(:have_two_accounts)
    assert_equal 2, user.accounts.size
  end

  test "user whose age is smaller than 18 is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2020, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without firstname is invalid" do
    user = User.new(lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without lastname is invalid" do
    user = User.new(firstname: "tao", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without email is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user with invalid email format should not pass validation" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huang" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without birth date is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without phone is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" ,birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert_not user.valid?
  end

  test "user without password is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" ,phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), is_female: false)
    assert_not user.valid?
  end

  test "user withou gender is invalid" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890")
    assert_not user.valid?
  end



# todo
  test "user with full information should pass validations" do
    user = User.new(firstname: "tao", lastname: "huang", email: "huangtao@abc.com" , phone: 13756181581, birth_date: DateTime.new(2001, 11, 15), password: "1234567890", is_female: false)
    assert user.valid?

  end

end
