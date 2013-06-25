class User < ActiveRecord::Base
  has_many :stories

  has_secure_password
  validates :password, :presence => true,  :on => :save

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
end