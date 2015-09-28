require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @title = RentFeedback::Application::APP_NAME
  end
  test 'should get home' do
    get :home
    assert_response :success
    assert_select 'title', @title
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', "About | #{@title}"
  end

  test 'should get contact' do
    get :contact
    assert_response :success
    assert_select 'title', "Contact | #{@title}"
  end

  test 'should get help' do
    get :help
    assert_response :success
    assert_select 'title', "Help | #{@title}"
  end

  test 'home page should not have Sign Up link when logged in' do
    sign_in users(:david)
    get :home
    assert_select 'a[href=?]', 'users/sign_up', count: 0
  end

  test 'Log in link should go when logged in' do
    get :home
    assert_select 'a[href=?]', '/users/sign_in', count: 1
    sign_in users(:david)
    get :home
    assert_select 'a[href=?]', '/users/sign_in', count: 0
  end
end
