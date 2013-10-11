class KusController < ApplicationController
	before_filter :require_login, except: [:show]
	before_filter(only: [:edit, :update]) { |c| c.require_owner Ku.find(params[:id]) }
	def new
		@story = Story.find(params[:story_id])
		@ku = @story.kus.build
		parent = Ku.find(params[:parent_id])
		@text = parent.filter(:body)
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
		@text = @ku.filter(:body)
		@story = @ku.story
		@comment = Comment.new
	end

	def vote
		@ku = Ku.find(params[:id])
		@story = @ku.story
		if @ku.votes.where(user_id: current_user.id).exists?
			handle_existing_vote(@ku)
		else
			Vote.create(value: params[:value], voteable_type: "Ku", voteable_id: @ku.id, user_id: current_user.id)
		end
		redirect_to ku_path(@ku)
	end

	private

	def handle_existing_vote(ku)
		vote = ku.votes.where(user_id: current_user.id).first
		if vote.value.to_s == params[:value]
			vote.destroy
		else
			vote.update_attributes(value: params[:value])
		end
	end
end