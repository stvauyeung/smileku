class KusController < ApplicationController
	before_filter :require_login, only: [:new, :create]

	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build
	end

	def create
		@story = Story.find(params[:story_id])
		@ku = Ku.create(params[:ku])
		if @ku.save
			@ku.update_attributes(story_id: @story.id, user_id: current_user.id)
			flash[:success] = "You successfully published a ku."
			redirect_to story_ku_path(@story, @ku)
		else
			flash[:error] = "You should write something!"
			render :new
		end
	end

	def show
		@story = Story.find(params[:story_id])
		@ku = Ku.find(params[:id])
		render template: 'shared/show'
	end
end