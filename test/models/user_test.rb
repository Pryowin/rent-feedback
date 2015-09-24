require 'test_helper'

class UserTest < ActiveSupport::TestCase

  MAX_NAME_LENGTH = User::MAX_NAME_LENGTH
  MAX_HANDLE_LENGTH = User::MAX_HANDLE_LENGTH

  def setup
    @user = users(:david)
    @other = users(:amber)
  end

  test "Handle cannot be blank" do
    @user.handle = ""
    assert_not @user.valid?
  end

  test "Name cannot be blank" do
    @user.handle = ""
    assert_not @user.valid?
  end

  test "Handle Length must be less than Max" do
    @user.handle = 'a' * (MAX_HANDLE_LENGTH + 1)
    assert_not @user.valid?, "Over Max Length"
    @user.handle = 'a' * (MAX_HANDLE_LENGTH - 1)
    assert @user.valid?, "Under Max Length"
  end
  test "Name Length must be less than Max" do
    @user.name = 'a' * (MAX_NAME_LENGTH + 1)
    assert_not @user.valid?, "Over Max Length"
    @user.name = 'a' * (MAX_NAME_LENGTH - 1)
    assert @user.valid?, "Under Max Length"
  end

  test "Handle must be unique" do
    @other.handle = @user.handle
    assert_not @other.valid?
    @other.handle.upcase!
    assert_not @other.valid?
  end

  test "Handle must not be profane" do
    @user.handle ="Shitface"
    assert_not @user.valid?
  end

  test "Name must not be profane" do
    @user.name ="Shitface"
    assert_not @user.valid?
  end


end
