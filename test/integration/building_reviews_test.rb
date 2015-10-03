require 'test_helper'

class BuildingReviewsTest < ActionDispatch::IntegrationTest
  test 'review page appears' do
    get building_path(buildings(:one))
    assert_template 'buildings/show'
    assert_select 'ul.reviews', 1, 'Reviews table missing'
    assert_select 'section.buildingInfo', 1, 'Building info missing'
    assert_select 'div.review-count', 1, 'Review count header missing'
    assert_select 'div.pagination', 0, 'Pagination should not be present'
    assert_template partial: '_review', count: 1
    assert_select 'a[href=?]', buildings_path, 2, 'Back button missing'
    assert_select 'a[href=?]', edit_building_path, 0,
                  'Edit only if logged in as admin'
  end

  test 'pagination appaers with many reviews' do
    get building_path(buildings(:three))
    assert_select 'div.pagination', 1, 'Pagination missing'
  end

  test 'No edit if logged in as user' do
    sign_in_as(users(:amber))
    get building_path(buildings(:one))
    assert_select 'a[href=?]', buildings_path, 2, 'Back button missing'
    assert_select 'a[href=?]', edit_building_path, 0,
                  'Edit only if logged in as admin'
  end

  test 'Edit if logged in as admin' do
    sign_in_as(users(:david))
    get building_path(buildings(:one))
    assert_select 'a[href=?]', buildings_path, 2, 'Back button missing'
    assert_select 'a[href=?]', edit_building_path, 1,
                  'Edit missing'
  end
end
