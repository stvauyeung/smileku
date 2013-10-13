class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :ku
	validates_presence_of :body
	include Markdown
end