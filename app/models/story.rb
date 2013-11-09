class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  validates :title, presence: true
  validates :large_cover, presence: true
  mount_uploader :large_cover, CoverUploader
  include Markdown

  def self.most_recent
  	last(10).reverse
  end

  def truncated_title
  	title.truncate(25)
  end

  def original_ku
    self.kus.first(:order => 'created_at ASC')
  end

  def set_first_ku(ku, user)
    self.save
    ku.save
    self.update_column(:user_id, user.id)
    ku.update_column(:user_id, user.id)
    self.kus << ku
  end
end