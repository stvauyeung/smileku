class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :ku
	has_many :activities, as: :subject
	validates_presence_of :body
	include Markdown
end