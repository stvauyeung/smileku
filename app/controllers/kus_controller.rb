class KusController < ApplicationController
	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build(parent_id: params[:parent_id])
	end

	def create
		
	end
end