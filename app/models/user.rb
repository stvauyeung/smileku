class User < ActiveRecord::Base
  has_many :stories

  validates :username, :presence => true
  validates :email, :presence => true
end