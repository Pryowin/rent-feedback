require 'test_helper'

class BuildingTest < ActiveSupport::TestCase

  test 'Provides Country Name' do
    assert buildings(:one).country_name, 'United States'
  end

  test 'Provides Country code if code is not valid' do
    assert buildings(:two).country_name, buildings(:two).country
  end

  test 'Provides State Name' do
    assert buildings(:one).state_name, 'California'
  end

  test 'Provides State code if Country code is not valid' do
    assert buildings(:two).state_name, buildings(:two).state
  end

end
