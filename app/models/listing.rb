class Listing < ActiveRecord::Base
	belongs_to :user
	belongs_to :story
	validates_uniqueness_of :user_id, scope: :story_id
	validates_presence_of :user_id
	validates_presence_of :story_id
end