require 'test_helper'

class UserReviewsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:david)
    @user_verbose = users(:schrodie)
  end

  test 'review page appears' do
    sign_in_as (@user)
    get user_path(@user)
    assert_response :success
    assert_template 'users/show'
    assert_select 'ul.reviews', 1,'Reviews table missing'
    assert_select 'div.user-table', 1, 'User info missing'
    assert_select 'div.review-count', 1, 'Review count header missing'
    assert_select 'div.pagination', 0, 'Pagination should not be present'
    assert_template partial: '_review', count: 1 
  end

  test 'pagination for user with many posts' do
    sign_in_as(@user_verbose)
    get user_path(@user_verbose)
    assert_select 'div.pagination',1
  end
end
