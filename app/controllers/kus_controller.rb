class KusController < ApplicationController
	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build
	end

	def create
		
	end
end