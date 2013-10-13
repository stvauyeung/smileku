class StaticsController < ApplicationController
	layout :resolve_layout

	def front
		@user = User.new
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