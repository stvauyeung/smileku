class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  validates :title, presence: true
  validates :large_cover_url, presence: true
end