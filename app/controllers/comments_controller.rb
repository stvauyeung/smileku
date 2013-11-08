class CommentsController < ApplicationController
	before_filter :require_login

	def create
		@ku = Ku.find(params[:ku_id])
		comment = @ku.comments.build(params[:comment].merge!(user: current_user))
		if comment.save
			redirect_to @ku
		else
			flash[:error] = "There was something wrong with your comment, please try again."
			redirect_to @ku
		end
	end
end