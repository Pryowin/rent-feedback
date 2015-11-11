require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @building = buildings(:one)
    @user = users(:amber)
    @admin = users(:david)
  end

  test 'should get index with alpha search params' do
    get :index, search: @building.city
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  test 'should get index with numeric search params' do
    get :index, search: @building.postal_code
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  test 'should get index without search params' do
    get :index
    assert_response :success
    assert_not_nil assigns(:buildings)
  end

  test 'should get new' do
    sign_in @user
    get :new
    assert_response :success
  end

  test 'should not get new if not logged in' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'should create building' do
    sign_in @user
    assert_difference('Building.count') do
      create('Washington')
    end
    assert_redirected_to building_path(assigns(:building))
  end

  test 'should not create building if not logged in' do
    assert_no_difference('Building.count') do
      create('Washington')
    end
    assert_redirected_to new_user_session_url
  end

  test 'should not create building with invalid data' do
    sign_in @user
    assert_no_difference('Building.count') do
      create('')
    end
  end

  test 'should show building' do
    get :show, id: @building
    assert_response :success
  end

  test 'should get edit' do
    sign_in @admin
    get :edit, id: @building
    assert_response :success
  end

  test 'should not get edit if not logged in' do
    get :edit, id: @building
    assert_redirected_to new_user_session_url
  end

  test 'should not get edit if not admin' do
    sign_in @user
    get :edit, id: @building
    assert_redirected_to root_url
  end

  test 'should update building' do
    sign_in @admin
    update(@building.city)
    assert_redirected_to building_path(assigns(:building))
  end

  test 'should not update building if not logged in' do
    update(@building.city)
    assert_redirected_to new_user_session_url
  end

  test 'should not update building if not admin' do
    sign_in @user
    update(@building.city)
    assert_redirected_to root_url
  end

  test 'should not update building if not valid' do
    sign_in @admin
    update('')
    assert_select 'div#error_explanation'
  end

  test 'should destroy building' do
    sign_in @admin
    assert_difference('Building.count', -1) do
      delete :destroy, id: @building
    end
    assert_redirected_to buildings_path
  end

  test 'should not destroy building if not logged in' do
    assert_no_difference 'Building.count' do
      delete :destroy, id: @building
    end
    assert_redirected_to new_user_session_url
  end

  test 'should not destroy building if not admin' do
    sign_in @user
    assert_no_difference 'Building.count' do
      delete :destroy, id: @building
    end
    assert_redirected_to root_url
  end

  test 'Do not create if address not found' do
    sign_in @user
    assert_no_difference 'Building.count' do
      post :create,
           building: { city: 'A',
                       country: 'US',
                       postal_code: 'A' ,
                       state: 'A',
                       street_address_3: 'A',
                       street_name: 'A',
                       building_number: 1,
                       street_address_2: ''}
     end
  end

  test 'Subscribe should increase number of subscriptions' do
    sign_in @user
    assert_difference('Subscription.count',1) do
      post :subscribe, building_id: @building.id
    end
  end

  test 'UnSubscribe should decrease number of subscriptions' do
    sign_in @admin
    sub_id = @building.check_subscription(@admin.id)[:id]
    assert_difference('Subscription.count',-1) do
      delete :unsubscribe, building_id: @building.id, subscription_id: sub_id
    end
  end

  private

  def create(city)
    post :create,
         building: { city: city,
                     country: 'US',
                     postal_code: '20500' ,
                     state: 'DC',
                     street_address_3: '',
                     street_name: 'Pennsylvania Avenue' ,
                     building_number: 1600,
                     street_address_2: ''}

  end

  def update(city)
    patch :update, id: @building,
                   building: { city: city,
                               country: @building.country,
                               postal_code: @building.postal_code,
                               state: @building.state,
                               street_address_3: @building.street_address_3,
                               street_name: @building.street_name,
                               building_number: @building.building_number,
                               street_address_2: @building.street_address_2 }
  end
end
