class StaticsController < ApplicationController
	layout :resolve_layout

	def front
		@user = User.new
		@stories = Story.most_recent(5)
	end

	def contact
		
	end

	private

	def resolve_layout
		case action_name
		when "front"
			"front"
		else
			"application"
		end
	end
end