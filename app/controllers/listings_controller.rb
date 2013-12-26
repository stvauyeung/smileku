class ListingsController < ApplicationController
	before_filter :require_login

	def create
		@story = Story.find(params[:listing][:story_id])
		Listing.create(user_id: current_user.id, story_id: @story.id)
		redirect_to @story
	end

	def destroy
		@story = Story.find(params[:listing][:story_id])
		redirect_to @story
	end
end