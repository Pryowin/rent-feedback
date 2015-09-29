require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  MAX_HEADLINE_LENGTH = Review::MAX_HEADLINE_LENGTH

  def setup
    @review = reviews(:one)
    @review.author_id = users(:david).id
    @review.subject_id = buildings(:one).id
  end

  test 'author must be present' do
    @review.author_id = ''
    assert_not @review.valid?
    @review.author_id = 101
    assert_not @review.valid?, 'User id does not exist'
  end

  test 'building must be present' do
    @review.subject_id = 101
    assert_not @review.valid?, 'Building does not exist'
  end

  # OPTIMIZE Deal with duplication of code
  test 'overall rating must be within range' do
    @review.overall_rating = 0
    assert_not @review.valid?, 'Rating too low'
    @review.overall_rating = 6
    assert_not @review.valid?, 'Rating too high'
    @review.overall_rating = 3
    assert @review.valid?, 'Rating in range'
  end
  test 'location rating must be within range' do
    @review.location_rating = 0
    assert_not @review.valid?, 'Rating too low'
    @review.location_rating = 6
    assert_not @review.valid?, 'Rating too high'
    @review.location_rating = 3
    assert @review.valid?, 'Rating in range'
  end
  test 'value rating must be within range' do
    @review.value_rating = 0
    assert_not @review.valid?, 'Rating too low'
    @review.value_rating = 6
    assert_not @review.valid?, 'Rating too high'
    @review.value_rating = 3
    assert @review.valid?, 'Rating in range'
  end
  test 'cleanliness rating must be within range' do
    @review.cleanliness_rating = 0
    assert_not @review.valid?, 'Rating too low'
    @review.cleanliness_rating = 6
    assert_not @review.valid?, 'Rating too high'
    @review.cleanliness_rating = 3
    assert @review.valid?, 'Rating in range'
  end
  test 'facilities rating must be within range' do
    @review.facilities_rating = 0
    assert_not @review.valid?, 'Rating too low'
    @review.facilities_rating = 6
    assert_not @review.valid?, 'Rating too high'
    @review.facilities_rating = 3
    assert @review.valid?, 'Rating in range'
  end

  test 'invalid headline' do
    @review.headline = 'a' *(MAX_HEADLINE_LENGTH + 1)
    assert_not @review.valid?, 'Headline too long'
    @review.headline = 'shitface'
    assert_not @review.valid?, 'Headline profane'
    @review.headline = ''
    assert_not @review.valid?, 'Headline missing'
  end

  test 'invalid details' do
    @review.details = 'shitface'
    assert_not @review.valid?, 'Details profane'
    @review.details = ''
    assert_not @review.valid?, 'Details missing'
  end

end
