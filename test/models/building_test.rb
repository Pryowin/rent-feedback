require 'test_helper'

class BuildingTest < ActiveSupport::TestCase

  def setup
      @building = buildings(:one)
      @user = users(:david)
      @other_user = users(:amber)
      @nosub_user = users(:schrodie)
  end

  test 'Provides Country Name' do
    assert @building.country_name, 'United States'
  end

  test 'Provides Country code if code is not valid' do
    assert buildings(:two).country_name, buildings(:two).country
  end

  test 'Provides State Name' do
    assert @building.state_name, 'California'
  end

  test 'Provides State code if Country code is not valid' do
    assert buildings(:two).state_name, buildings(:two).state
  end

  test 'Reject building if address is invalid' do
    @building.skip_validation = false
    assert_not @building.valid?
  end

  test 'Allow building if address is valid' do
    @building.skip_validation = false
    @building.building_number = 1600
    @building.street_name = 'Pennsylvania Avenue'
    @building.city = 'Washington'
    @building.state = 'DC'
    @building.postal_code = '20500'
    assert @building.valid?
  end

  test 'Check Active Subscription' do
    create_subscription(true)
    user_subscription = @building.check_subscription(@other_user.id)
    assert_equal user_subscription[:exists],true, 'Sub should exist'
    assert_equal user_subscription[:active],true, 'Sub should be active'
    user_subscription = @building.check_subscription(@nosub_user.id)
    assert_equal user_subscription[:exists],false,'Sub should not exist'
  end

  test 'Check InActive Subscription' do
    create_subscription(false)
    user_subscription = @building.check_subscription(@other_user.id)
    assert_equal user_subscription[:exists],true, 'Sub should exist'
    assert_equal user_subscription[:active],false, 'Sub should be active'
  end

  def create_subscription(active)
    @subscription = Subscription.new
    @subscription.building_id = @building.id
    @subscription.user_id = @other_user.id
    @subscription.active = active
    assert @subscription.valid?, 'Subsciption should be valid'
    @subscription.save
  end
end
