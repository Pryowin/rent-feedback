require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  def setup
    @subscription = subscriptions(:one)
  end

  test 'User id cannot be blank' do
    @subscription.user_id = nil
    assert_not @subscription.valid?
  end

  test 'One of building/city/zip must be specifiied' do
    @subscription.building_id = nil
    @subscription.city = nil
    @subscription.postal_code = nil
    assert_not @subscription.valid?
  end

  test 'valid if one is provided' do
    @subscription.building_id = 1
    assert @subscription.valid?, 'Building Provided'
    @subscription.building_id = nil
    @subscription.city = 'City'
    assert @subscription.valid?, 'City Provided'
    @subscription.city = nil
    @subscription.postal_code = '99999'
    assert @subscription.valid?, 'Postal Code Provided'
  end

  test 'not valid if building and city provided' do
    @subscription.city = 'City'
    assert_not @subscription.valid?
  end
  test 'not valid if building and zip provided' do
    @subscription.postal_code = '99999'
    assert_not @subscription.valid?
  end
  test 'not valid if zip and city provided' do
    @subscription.city = 'City'
    @subscription.postal_code = '99999'
    @subscription.building_id = nil
    assert_not @subscription.valid?
  end

  test 'New subscriptions are created active' do
    subscription = Subscription.new
    subscription.user_id = @subscription.user_id
    subscription.city = 'test'
    subscription.save
    check_sub = Subscription.find_by city: 'test'
    assert_equal check_sub.active, true
  end


end
