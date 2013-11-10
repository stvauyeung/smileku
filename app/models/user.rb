class User < ActiveRecord::Base
  require 'uri'
  has_many :stories
  has_many :kus
  has_many :votes
  has_many :comments
  has_secure_password
  validates :password, :presence => true,  :on => :create
  validates :username, :presence => true, :uniqueness => true, format: { with: /^[a-z0-9_]+$/i, message: "only letters, numbers or underscores"}, length: { maximum: 30 }
  validates :email, :presence => true, :uniqueness => true
  before_create :generate_token
  before_create :default_values
  mount_uploader :photo, ProfileUploader
  extend FriendlyId
  friendly_id :username

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

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def update_password(password)
    self.password = password
    generate_token
    save!
  end

  def site_link
    uri = URI::parse(self.website)
    if uri.scheme.nil? && uri.host.nil?
      unless uri.path.nil?
        uri.scheme = "http"
        uri.host = uri.path
        uri.path = ""
      end
    end
    uri.to_s
  end

  private

  def default_values
    self.bio ||= "This person hasn't written their bio yet.."
    self.location ||= "Planet Earth"
  end
end