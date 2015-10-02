require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @review = reviews(:two)
    @user = users(:amber)
    @other_review = reviews(:one)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @review.id
    assert_response :success
  end

  test 'Cannot edit another users review' do
    sign_in @user
    get :edit, id: @other_review.id
    assert_redirected_to root_url
  end

  test "should get show" do
    sign_in @user
    get :show, id: @review.id
    assert_response :success
  end

  test "Index should redirect to home page" do
    get :index
    assert_redirected_to root_url
  end

  test "go to home page if review does not exist" do
    get :show, id: 42
    assert_redirected_to root_url
  end
end
