class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  validates :title, presence: true
  validates :large_cover_url, presence: true

  def self.most_recent
  	last(6).reverse
  end
end