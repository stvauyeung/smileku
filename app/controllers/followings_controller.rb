class FollowingsController < ApplicationController
	before_filter :require_login
	
	def create
		@user = User.find(params[:following][:followed_id])
		redirect_to @user
	end
end