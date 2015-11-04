class Review < ActiveRecord::Base
  belongs_to :building, foreign_key: 'subject_id'
  belongs_to :user, foreign_key: 'author_id'

  default_scope -> { order(created_at: :desc) }

  MAX_HEADLINE_LENGTH = 80
  CURRENT_YEAR = DateTime.now.year.to_i
  MIN_RATING = 1
  MAX_RATING = 5
  MONTHS_IN_YEAR = 12

  validates :author_id, presence: true
  validates :user, presence: true

  validates :subject_id, presence: true
  validates :building, presence: true

  validates :overall_rating,
            numericality: { only_integer: true,
                            greater_than_or_equal_to:  MIN_RATING,
                            less_than_or_equal_to: MAX_RATING }

  validates :location_rating,
             numericality: { only_integer: true,
                             greater_than_or_equal_to:  MIN_RATING,
                             less_than_or_equal_to:  MAX_RATING }

  validates :value_rating,
             numericality: { only_integer: true,
                             greater_than_or_equal_to:  MIN_RATING,
                             less_than_or_equal_to: MAX_RATING }

  validates :facilities_rating,
             numericality: { only_integer: true,
                             greater_than_or_equal_to:  MIN_RATING,
                             less_than_or_equal_to: MAX_RATING }

  validates :cleanliness_rating,
             numericality: { only_integer: true,
                             greater_than_or_equal_to:  MIN_RATING,
                             less_than_or_equal_to: MAX_RATING }

  validates :from_month,
             numericality: { only_integer: true,
                             greater_than_or_equal_to: 0,
                             less_than_or_equal_to: MONTHS_IN_YEAR }
  validates :to_month,
             numericality: { only_integer: true,
                             greater_than_or_equal_to: 0,
                             less_than_or_equal_to: MONTHS_IN_YEAR }

  validates :from_year,
             numericality:{ only_integer: true,
                            greater_than_or_equal_to: 1900,
                            less_than_or_equal_to: CURRENT_YEAR},
             unless: "from_year == 0"

   validates :to_year,
              numericality:{ only_integer: true,
                             greater_than_or_equal_to: 1900,
                             less_than_or_equal_to: CURRENT_YEAR},
              unless: "to_year == 0"

  validates :headline, presence: true,
                       length:   { maximum: MAX_HEADLINE_LENGTH },
                       obscenity: true

  validates :details, presence: true,
                      obscenity: true

  validate :to_date_must_be_earlier_than_from_date,
           :month_requires_year

  def to_date_must_be_earlier_than_from_date
    return if to_year == 0
    if from_year == 0 && to_year != 0
      errors.add(:from_year, 'From date must be specified if to date is enetered')
    end
    errmsg = 'To date cannot be earlier than from date'
    errors.add(:from_year, errmsg) if to_year < from_year
    errors.add(:from_year, errmsg) if to_year == from_year && to_month < from_month
  end

  def month_requires_year
    errmsg = 'Must enter a month if year is specified'
    errors.add(:from_year, errmsg) if from_year == 0 and from_month != 0
    errors.add(:to_year, errmsg) if to_year == 0 and to_month != 0
  end

end
