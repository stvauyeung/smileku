class Story < ActiveRecord::Base
  belongs_to :user
  has_many :kus
  validates :title, :large_cover_url, presence: true
end