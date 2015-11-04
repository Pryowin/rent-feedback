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

  test 'from month range' do
    @review.to_year = 0
    @review.to_month = 0
    month_range_check("from_month")
  end
  test 'to month range' do
    @review.from_year = 2010
    month_range_check("to_month")
  end

  test 'from year range' do
    @review.to_year = 0
    @review.to_month = 0
    @review.from_month = 0
    year_range_check("from_year")
  end
  test 'to year range' do
    @review.from_year = 2010
    @review.from_month = 0
    @review.to_month = 0
    year_range_check("to_year")
  end

  test 'to year cannot be less than from year if non-zero' do
      @review.from_year = 2015
      @review.to_year = 2014
      @review.to_month = 1
      @review.from_month = 2
      assert_not @review.valid?, 'From year after to year'
  end

  test 'to year can be less than from year if zero' do
      @review.from_year = 2015
      @review.to_year = 0
      @review.from_month = 0
      @review.to_month = 0
      assert @review.valid?, 'To year is blank, so can be less than from'
  end

  test 'to year cannot be specified if from year is zero' do
      @review.from_year = 0
      @review.to_year = 2015
      @review.from_month = 0
      @review.to_month = 0
      assert_not @review.valid?
  end

  test 'if from and to year are equal from month cannot be after to month' do
    @review.from_year = 2015
    @review.to_year = 2015
    @review.to_month = 1
    @review.from_month = 2
    assert_not @review.valid?, 'From month before to month'
    @review.to_month = 2
    assert @review.valid?, 'From month equals to month'
    @review.to_month = 3
    assert @review.valid?, 'From month after to month'
  end

  test 'from month requires from year to be present' do
    @review.from_year = 0
    @review.from_month = 1
    @review.to_year = 0
    @review.to_month = 0
    assert_not @review.valid?, 'From year missing'
  end
  test 'to month requires to year to be present' do
    @review.from_year = 2015
    @review.from_month = 1
    @review.to_year = 0
    @review.to_month = 1
    assert_not @review.valid?, 'To year missing'
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

  def month_range_check(month)
    @review.send("#{month}=",-1)
    assert_not @review.valid?, "#{month} too low"
    @review.send("#{month}=",13)
    assert_not @review.valid?, "#{month} too high"
    @review.send("#{month}=",0)
    assert @review.valid?, "#{month} can be blank"
    @review.send("#{month}=",5)
    assert @review.valid?, "#{month} is valid"
  end

  def year_range_check(year)
    current_year = DateTime.now.year.to_i
    @review.send("#{year}=",1899)
    assert_not @review.valid?, "#{year} too low"
    @review.send("#{year}=",current_year + 1)
    assert_not @review.valid?, "#{year} too high"
    @review.send("#{year}=",current_year -1)
    assert @review.valid?, "#{year} is valid"
    @review.send("#{year}=",0)
    assert @review.valid?, "#{year} can be blank"
  end
end
