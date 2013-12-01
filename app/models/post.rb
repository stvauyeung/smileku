class Post < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	validates :text, presence: true
	validates :header, presence: true
	validates :mrec, presence: true
	include Markdown
	mount_uploader :mrec, PostMrecUploader
	mount_uploader :header, PostHeaderUploader
end