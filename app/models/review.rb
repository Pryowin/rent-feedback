class Review < ActiveRecord::Base
  belongs_to :building, foreign_key: 'subject_id'
  belongs_to :user, foreign_key: 'author_id'
  validates_presence_of :user
  validates_presence_of :building

  default_scope -> { order(created_at: :desc) }

  MAX_HEADLINE_LENGTH = 80

  validates :author_id,  presence: true
  validates :subject_id, presence: true

  validates :overall_rating, numericality: { only_integer: true,
                                             :greater_than_or_equal_to => 1,
                                             :less_than_or_equal_to => 5 }

  validates :location_rating, numericality: { only_integer: true,
                                             :greater_than_or_equal_to => 1,
                                             :less_than_or_equal_to => 5 }

  validates :value_rating, numericality: { only_integer: true,
                                           :greater_than_or_equal_to => 1,
                                          :less_than_or_equal_to => 5 }

  validates :facilities_rating, numericality: { only_integer: true,
                                                :greater_than_or_equal_to => 1,
                                               :less_than_or_equal_to => 5 }

  validates :cleanliness_rating, numericality: { only_integer: true,
                                                 :greater_than_or_equal_to => 1,
                                                 :less_than_or_equal_to => 5 }
  validates :headline, presence: true,
                       length:   { maximum: MAX_HEADLINE_LENGTH },
                       obscenity: true

  validates :details, presence: true,
                      obscenity: true
end
