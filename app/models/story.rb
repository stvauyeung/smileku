class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  has_many :activities, as: :subject
  validates :title, presence: true
  validates :large_cover, presence: true
  mount_uploader :large_cover, CoverUploader
  include Markdown
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :listings, foreign_key: :story_id

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def self.most_recent(number)
  	last(number).reverse
  end

  def self.find_longest(number)
    all.sort_by{ |story| story.kus.count }.last(number).reverse
  end

  def self.sort_by_length
    all.sort_by{ |story| story.kus.count }.reverse
  end

  def truncated_title
  	title.truncate(25)
  end

  def original_ku
    self.kus.first(:order => 'created_at ASC')
  end

  def author_name
    self.user.username
  end

  # def set_first_ku(ku, user)
  #   self.save
  #   ku.save
  #   self.update_column(:user_id, user.id)
  #   ku.update_column(:user_id, user.id)
  #   self.kus << ku
  # end
end