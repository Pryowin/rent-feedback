require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "header links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", 'users',count:0
    assert_select "a[href=?]", buildings_path
  end



  test "home page links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",  'users/sign_up'
  end


end
