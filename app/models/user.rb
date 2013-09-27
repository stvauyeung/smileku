class User < ActiveRecord::Base
  has_many :stories
  has_many :kus
  has_many :votes
  has_secure_password
  validates :password, :presence => true,  :on => :create
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  def has_secure_password?
  	true
  end

  def owns(object)
  	if object.user_id == self.id
  		true
  	else
  		false
  	end
  end
end