class Subscription < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id'

  validates :user_id, presence: true
  validates :user, presence: true
end
