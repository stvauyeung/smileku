class Post < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true
	validates :text, presence: true
	validates :header, presence: true
	validates :mrec, presence: true
	extend FriendlyId
	friendly_id :title, use: :slugged
	include Markdown
	mount_uploader :mrec, PostMrecUploader
	mount_uploader :header, PostHeaderUploader

	def self.most_recent(number)
		last(number).reverse
	end

	def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end