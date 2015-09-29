class Building < ActiveRecord::Base
  validates :city,        presence: true
  validates :country,     presence: true
  validates :street_name, presence: true
end
