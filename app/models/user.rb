require 'obscenity/active_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  MAX_HANDLE_LENGTH = 20
  MAX_NAME_LENGTH = 50

  validates :name,  presence: true

  validates :handle,  presence: true,
                      length: {maximum: MAX_HANDLE_LENGTH},
                      uniqueness: {case_sensitive: false},
                      obscenity: true

  validates :name,  presence: true,
                    length: {maximum: MAX_NAME_LENGTH},
                    obscenity: true



end
