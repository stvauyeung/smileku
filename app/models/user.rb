class User < ActiveRecord::Base
  require 'uri'
  has_many :stories
  has_many :kus
  has_many :votes
  has_many :comments
  has_many :activities

  has_secure_password
  before_create :generate_token
  before_create :default_values
  mount_uploader :photo, ProfileUploader
  validates :password, :presence => true,  :on => :create
  validates :username, :presence => true, :uniqueness => { case_sensitive: false }, format: { with: /^[a-z0-9_]+$/i, message: "only letters, numbers or underscores"}, length: { maximum: 30 }
  validates :email, :presence => true, :uniqueness => true

  has_many :followings, foreign_key: :follower_id
  has_many :is_follower, class_name: 'Following', foreign_key: :follower_id
  has_many :is_followed, class_name: 'Following', foreign_key: :followed_id

  has_many :listings, foreign_key: :user_id
  
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

  def following?(user)
    followings.find_by_followed_id(user.id)
  end

  def followers
    is_followed.pluck(:follower_id).map! { |u| User.find(u) }
  end

  def following
    is_follower.pluck(:followed_id).map! { |u| User.find(u) }
  end

  def follow!(user)
    followings.create(followed_id: user.id) if self != user
  end

  def listed?(story)
    listings.find_by_story_id(story.id)
  end

  def listed
    listings.order('created_at DESC').pluck(:story_id).map! { |s| Story.find(s) }
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