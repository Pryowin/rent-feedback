class Subscription < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id'

  validates :user_id, presence: true
  validates :user, presence: true

  validate :allow_one_and_only_one_subscription_type

  def allow_one_and_only_one_subscription_type
    if building_id.nil? && city.nil? && postal_code.nil?
      errmsg = 'Must provide city or postal code for a subscription'
      errors.add(:city,errmsg)
      errors.add(:postal_code,errmsg)
    end

    errmsg = 'Select just one item for a subscription'

    unless building_id.nil?
      errors.add(:city,errmsg) unless city.nil?
      errors.add(:postal_code,errmsg) unless postal_code.nil?
    end

    if building_id.nil? && !city.nil? && !postal_code.nil?
      errors.add(:city,errmsg)
      errors.add(:postal_code,errmsg)
    end

  end

end
