require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:amber)
    @other_user = users(:david)
    @admin = users(:david)
  end

  test 'should get profile' do
    sign_in @user
    get :show, id: @user.id
    assert_response :success
  end

  test 'should go back to home if different user' do
    sign_in @user
    get :show, id: @other_user.id
    assert_redirected_to root_url
  end

  test 'should go home if not logged in' do
    get :show, id: @user.id
    assert_redirected_to root_url
  end

  test 'should get profile if logged in as admin' do
    sign_in @admin
    get :show, id: @user.id
    assert_response :success
  end

  test 'Index redirects to home' do
    get :index
    assert_redirected_to root_url, 'Go Home if not signed in'
    sign_in @user
    get :index
    assert_redirected_to root_url, 'Go Home if signed in'
  end

  test 'edit redirects to home' do
    get :edit, id: @user.id
    assert_redirected_to root_url, 'Go Home if not signed in'
    sign_in @user
    get :edit, id: @user.id
    assert_redirected_to root_url, 'Go Home if  signed in'
  end

  test 'delete redirects to home' do
    @user = users(:amber)
    delete :destroy, id: @user.id
    assert_redirected_to root_url, 'Delete: Go Home if not signed in'

    sign_in @user
    delete :destroy, id: @user.id
    assert_redirected_to root_url, 'Delete: Go Home if signed in'
  end
end
