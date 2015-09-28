# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:                'David Burke',
             email:               'dburke@amberfire.net',
             handle:              'Pyrowin',
             admin:               true,
             renter:              true,
             password:            'foobar65',
             confirmed_at:        Time.now
            )

79.times do
  Building.create!(street_name:     Faker::Address.street_name,
                   city:            Faker::Address.city,
                   building_number: Faker::Address.building_number,
                   state:           Faker::Address.state_abbr,
                   postal_code:     Faker::Address.zip,
                   country:         'US'
                  )
end

10.times do
  Building.create!(street_name:     Faker::Address.street_name,
                   building_number: Faker::Address.building_number,
                   city:            'Redding',
                   state:           'CA',
                   postal_code:     '96001',
                   country:         'US'
                  )
end

10.times do
  Building.create!(street_name:     Faker::Address.street_name,
                   building_number: Faker::Address.building_number,
                   city:            'Redding',
                   state:           'CA',
                   postal_code:     '96003',
                   country:         'US'
                  )
end
