# Figure out how to simplify this controller.
#  - There's a lot of duplication for creating the instance variables
#  - Mismatches in the instance variables that are created in new/create and edit/update
class KusController < ApplicationController
	before_filter :require_login, except: [:show]
	before_filter(only: [:edit, :update]) { |c| c.require_owner Ku.find(params[:id]) }
	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build
		parent = Ku.find(params[:parent_id])
		@text = parent.filter(:body).html_safe
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
		@comment = Comment.new
		@comments = @ku.comments.order('created_at DESC')
	end

	def vote
		@ku = Ku.find(params[:id])
		@story = @ku.story
		Vote.for_ku(@ku, current_user, params[:value])
		redirect_to ku_path(@ku)
	end
end