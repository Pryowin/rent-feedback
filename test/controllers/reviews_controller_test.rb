require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @review = reviews(:one)
    @user = users(:amber)
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

  test "should get show" do
    sign_in @user
    get :show, id: @review.id
    assert_response :success
  end

  test "Index should redirect to home page" do
    get :index
    assert_redirected_to root_url
  end

end
