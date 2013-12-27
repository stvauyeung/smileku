class ListingsController < ApplicationController
	before_filter :require_login

	def create
		@story = Story.find(params[:listing][:story_id])
		Listing.create(user_id: current_user.id, story_id: @story.id)
		redirect_to @story
	end

	def destroy
		listing = Listing.find(params[:id])
		@story = Story.find(listing.story_id)
		listing.delete if current_user.id == listing.user_id
		redirect_to @story
	end
end