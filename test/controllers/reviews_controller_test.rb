require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  # TODO: Add tests for create
  # TODO: Add test for update

  def setup
    @review = reviews(:two)
    @user = users(:amber)
    @other_review = reviews(:one)
  end

  test 'should get edit' do
    sign_in @user
    get :edit, id: @review.id
    assert_response :success
  end

  test 'Cannot edit another users review' do
    sign_in @user
    get :edit, id: @other_review.id
    assert_redirected_to root_url
  end

  test 'should get show' do
    sign_in @user
    get :show, id: @review.id
    assert_response :success
  end

  test 'Index should redirect to home page' do
    get :index
    assert_redirected_to root_url
  end

  test 'go to home page if review does not exist' do
    get :show, id: 42
    assert_redirected_to root_url
  end

  test 'new review requires logged in user' do
    get :new, subject: buildings(:one).id
    assert_redirected_to root_url
  end

  test 'new requires valid building to be passed' do
    sign_in @user
    get :new, subject: 42
    assert_redirected_to root_url
  end

  test 'should get new for logged in user and valid building' do
    sign_in @user
    get :new, subject: buildings(:one).id
    assert_response :success
  end

  test 'should not allow edit if not logged in' do
    get :edit, id: @review.id
    assert_redirected_to root_url
  end

  test 'can only edit own reviews' do
    sign_in @user
    get :edit, id: @other_review.id
    assert_redirected_to root_url
  end

end
