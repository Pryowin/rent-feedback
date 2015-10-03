require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest
  test 'Attempt to set admin via create' do
    post user_registration_path user: { name:     'John Hacker',
                                        email:    'hacker@amberfire.net',
                                        admin:    true,
                                        handle:   'hacker',
                                        password: 'password'
                                     }
    assert User.find_by(handle: 'hacker')
    assert_not User.find_by(handle: 'hacker').admin
  end
end
