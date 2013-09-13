class KusController < ApplicationController
	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build
	end

	def create
		story = Story.find(params[:story_id])
		ku = Ku.create(params[:ku])
		ku.update_column(:story_id, story.id)
		flash[:success] = "You successfully published a ku."
		redirect_to story_ku_path(story, ku)
	end

	def show
		
	end
end