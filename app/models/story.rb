class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  validates :title, presence: true
  validates :large_cover, presence: true
  mount_uploader :large_cover, CoverUploader

  def self.most_recent
  	last(10).reverse
  end

  def truncated_title
  	title.truncate(25)
  end

  def original_ku
    self.kus.first(:order => 'created_at ASC')
  end
end