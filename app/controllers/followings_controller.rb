class FollowingsController < ApplicationController
	before_filter :require_login

	def create
		@user = User.find(params[:following][:followed_id])
		current_user.followings.create(followed_id: @user.id) if current_user != @user
		redirect_to @user
	end

	def destroy
		following = Following.find(params[:id])
		@user = User.find(following.followed_id)
		following.destroy if current_user.id == following.follower_id
		redirect_to @user
	end
end