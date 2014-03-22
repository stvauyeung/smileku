class Activity < ActiveRecord::Base
	belongs_to :subject, polymorphic: true
	belongs_to :user

	def self.most_recent(number)
		all.sort_by(&:created_at).last(number).reverse
	end

	def story_image
		case action
		when 'created_comment'
			subject.ku.story.large_cover
		when 'created_ku'
			subject.story.large_cover
		when 'updated_ku'
			subject.story.large_cover
		when 'created_story'
			subject.large_cover
		end
	end

	def story_title
		case action
		when 'created_comment'
			subject.ku.story.title
		when 'created_ku'
			subject.story.title
		when 'updated_ku'
			subject.story.title
		when 'created_story'
			subject.title
		end
	end
end