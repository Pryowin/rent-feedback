require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @building = buildings(:one)
    @user = users(:amber)
    @admin = users(:david)
  end

  test "should get index with search params" do
    get :index, :search => @building.city
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  test "should get index without search params" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buildings)
  end


  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_url
  end


  test "should create building" do
    sign_in @user
    assert_difference('Building.count') do
      post :create,
            building: { city: @building.city,
                        country: @building.country,
                        postal_code: @building.postal_code,
                        state: @building.state,
                        street_address_3: @building.street_address_3,
                        street_name: @building.street_name,
                        building_number: @building.building_number,
                        street_address_2: @building.street_address_2 }
    end
    assert_redirected_to building_path(assigns(:building))
  end

  test "should not create building if not logged in" do
    assert_no_difference('Building.count') do
      post :create,
            building: { city: @building.city,
                        country: @building.country,
                        postal_code: @building.postal_code,
                        state: @building.state,
                        street_address_3: @building.street_address_3,
                        street_name: @building.street_name,
                        building_number: @building.building_number,
                        street_address_2: @building.street_address_2 }
    end
    assert_redirected_to new_user_session_url
  end

  test "should show building" do
    get :show, id: @building
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get :edit, id: @building
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get :edit, id: @building
    assert_redirected_to new_user_session_url
  end

  test "should not get edit if not admin" do
    sign_in @user
    get :edit, id: @building
    assert_redirected_to root_url
  end


  test "should update building" do
    sign_in @admin
    patch :update, id: @building,
            building: { city: @building.city,
                        country: @building.country,
                        postal_code: @building.postal_code,
                        state: @building.state,
                        street_address_3: @building.street_address_3,
                        street_name: @building.street_name,
                        building_number: @building.building_number,
                        street_address_2: @building.street_address_2 }
    assert_redirected_to building_path(assigns(:building))
  end

  test "should not update building if not logged in" do
    patch :update, id: @building,
            building: { city: @building.city,
                        country: @building.country,
                        postal_code: @building.postal_code,
                        state: @building.state,
                        street_address_3: @building.street_address_3,
                        street_name: @building.street_name,
                        building_number: @building.building_number,
                        street_address_2: @building.street_address_2 }
    assert_redirected_to new_user_session_url
  end

  test "should not update building if not admin" do
    sign_in @user
    patch :update, id: @building,
            building: { city: @building.city,
                        country: @building.country,
                        postal_code: @building.postal_code,
                        state: @building.state,
                        street_address_3: @building.street_address_3,
                        street_name: @building.street_name,
                        building_number: @building.building_number,
                        street_address_2: @building.street_address_2 }
    assert_redirected_to root_url
  end


  test "should destroy building" do
    sign_in @admin
    assert_difference('Building.count', -1) do
      delete :destroy, id: @building
    end
    assert_redirected_to buildings_path
  end

  test "should not destroy building if not logged in" do
    assert_no_difference'Building.count' do
      delete :destroy, id: @building
    end
    assert_redirected_to new_user_session_url
  end

  test "should not destroy building if not admin" do
    sign_in @user
    assert_no_difference'Building.count' do
      delete :destroy, id: @building
    end
    assert_redirected_to root_url
  end

end
