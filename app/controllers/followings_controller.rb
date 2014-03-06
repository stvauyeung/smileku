class FollowingsController < ApplicationController
	before_filter :require_login

	def create
		@user = User.find(params[:following][:followed_id])
		current_user.follow!(@user)
		AppMailer.delay.new_follower_email(@user, current_user)
		redirect_to @user
	end

	def destroy
		following = Following.find(params[:id])
		@user = User.find(following.followed_id)
		following.destroy if current_user.id == following.follower_id
		redirect_to @user
	end
end