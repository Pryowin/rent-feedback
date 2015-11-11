class Building < ActiveRecord::Base
  require 'carmen'
  include Carmen

  validates :city, presence: true
  validates :country, presence: true
  validates :street_name, presence: true
  validates_with GoogleAddressValidation

  has_many :reviews, foreign_key: 'subject_id'

  def country_name
    @country = Country.coded(self.country)
    return self.country if @country.nil?
    @country.name
  end

  def state_name
    @country = Country.coded(self.country)
    return self.state unless !@country.nil? && @country.subregions?
    return self.state if @country.subregions.coded(self.state).nil?
    @country.subregions.coded(self.state)
  end

  def check_subscription(user_id)
    subscription = Subscription.where("user_id = ? and building_id = ?",user_id,id).first
    return {exists: true, active: subscription.active, id: subscription.id} unless subscription.nil?
    return {exists: false, active: false}
  end
end
