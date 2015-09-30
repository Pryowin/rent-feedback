# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create!(name:                'David Burke',
             email:               'dburke@amberfire.net',
             handle:              'Pyrowin',
             admin:               true,
             renter:              true,
             password:            'foobar65',
             confirmed_at:        Time.zone.now
            )
User.create!(name:                'Amber Burke',
             email:               'amber@amberfire.net',
             handle:              'Amberfire',
             admin:               false,
             renter:              true,
             password:            'foobar65',
             confirmed_at:        Time.zone.now
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

3.times do
  Review.create!(author_id:            1,
                 subject_id:           1,
                 overall_rating:       Random.rand(1..5),
                 location_rating:      Random.rand(1..5),
                 value_rating:         Random.rand(1..5),
                 cleanliness_rating:   Random.rand(1..5),
                 facilities_rating:    Random.rand(1..5),
                 headline:             Faker::Lorem.sentence(1),
                 details:              Faker::Lorem
                                         .paragraph(Random.rand(1..7))
                )
end
2.times do
  Review.create!(author_id:            1,
                 subject_id:           2,
                 overall_rating:       Random.rand(1..5),
                 location_rating:      Random.rand(1..5),
                 value_rating:         Random.rand(1..5),
                 cleanliness_rating:   Random.rand(1..5),
                 facilities_rating:    Random.rand(1..5),
                 headline:             Faker::Lorem.sentence(1),
                 details:              Faker::Lorem
                                         .paragraph(Random.rand(1..7))
                )
end

Review.create!(author_id:            2,
               subject_id:           3,
               overall_rating:       Random.rand(1..5),
               location_rating:      Random.rand(1..5),
               value_rating:         Random.rand(1..5),
               cleanliness_rating:   Random.rand(1..5),
               facilities_rating:    Random.rand(1..5),
               headline:             Faker::Lorem.sentence(1),
               details:              Faker::Lorem
                                       .paragraph(Random.rand(1..7))
              )
