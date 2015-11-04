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

  test 'overall rating must be within range' do
    rating_check("overall_rating")
  end
  test 'location rating must be within range' do
    rating_check("location_rating")
  end
  test 'value rating must be within range' do
    rating_check("value_rating")
  end
  test 'cleanliness rating must be within range' do
    rating_check("cleanliness_rating")
  end
  test 'facilities rating must be within range' do
    rating_check("facilities_rating")
  end

  test 'invalid headline' do
    @review.headline = 'a' * (MAX_HEADLINE_LENGTH + 1)
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

  private

  def rating_check(rating)
      @review.send("#{rating}=", 0)
      assert_not @review.valid?, 'Rating too low'
      @review.send("#{rating}=", 6)
      assert_not @review.valid?, 'Rating too high'
      @review.send("#{rating}=", 3)
      assert @review.valid?, 'Rating in range'
  end
end
