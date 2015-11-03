require 'test_helper'

class BuildingTest < ActiveSupport::TestCase

  def setup
      @building = buildings(:one)
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

end
