require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

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

  test 'cannot delete if not logged in' do
    assert_no_difference 'Review.count' do
      delete :destroy, id: @review.id
    end
    assert_redirected_to root_url
  end

  test 'cannot delete if does not exist' do
    sign_in @user
    delete :destroy, id: 42
    assert_redirected_to root_url
  end

  test 'cannot delete if not author'  do
    sign_in @user
    assert_no_difference 'Review.count' do
      delete :destroy, id: @other_review.id
    end
    assert_redirected_to root_url
  end

  test 'can delete own reviews' do
    sign_in @user
    assert_difference 'Review.count', -1 do
      delete :destroy, id: @review.id
    end
    assert_redirected_to user_path
  end

  test 'should create review' do
    sign_in @user
    assert_difference('Review.count') do
      create(@review.overall_rating)
    end
  end

  test 'Review not created with invalid data' do
    sign_in @user
    assert_no_difference('Review.count') do
      create(6)
    end
  end

  private

  def create(rating)
    post :create,
         review: { author_id:         @user.id,
                  overall_rating:     rating,
                  cleanliness_rating: rating,
                  facilities_rating:  rating,
                  location_rating:    rating,
                  value_rating:       rating,
                  headline:           'Headline',
                  details:            'Details'
                },
       subject_id: buildings(:one)
  end

end
