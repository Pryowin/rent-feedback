require 'test_helper'


class UsersControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test "should get profile" do
    @user = users(:amber)
    sign_in @user
    get :show, id: @user.id
    assert_response :success
  end

  test "should go back to home if different user" do
    @user = users(:amber)
    sign_in @user
    @other_user = users(:david)
    get :show, id: @other_user.id
    assert_redirected_to root_url
  end

  test "should go home if not logged in" do
    @user = users(:amber)
    get :show, id: @user.id
    assert_redirected_to root_url
  end

  test "should get profile if logged in as admin" do
    @user = users(:david)
    sign_in @user
    get :show, id: users(:amber).id
    assert_response :success
  end

end
