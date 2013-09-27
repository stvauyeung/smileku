class KusController < ApplicationController
	before_filter :require_login, except: [:show]
	before_filter(only: [:edit, :update]) { |c| c.require_owner Ku.find(params[:id]) }

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
			redirect_to ku_path(@ku)
		else
			flash[:error] = "You should write something!"
			render :new
		end
	end

	def edit
		@ku = Ku.find(params[:id])
		@story = @ku.story
	end

	def update
		@ku = Ku.find(params[:id])
		if @ku.update_attributes(params[:ku])
			flash[:success] = "You've updated your ku!"
			redirect_to ku_path(@ku)
		else
			flash[:error] = "There was something wrong with your edit, try again?"
			render :edit
		end
	end

	def show
		@ku = Ku.find(params[:id])
		@story = @ku.story
		render template: 'shared/show'
	end

	def vote
		@ku = Ku.find(params[:id])
		@story = @ku.story
		Vote.create(value: params[:value], voteable_type: "Ku", voteable_id: @ku.id)
		render template: 'shared/show'
	end
end