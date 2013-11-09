class InvitesController < ApplicationController
	before_filter :require_login

	def new
		render_new(current_user)
	end

	def create
		user = current_user
		# Might want to break this into a form model (#3 from the link below)
		# http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/
		#
		# It might seem like overkill, but it really helps clean things up.
		#  Also, do some backend validation that the email is valid.
		if params[:name].present? && params[:email].present? && params[:message].present?
			AppMailer.invite_email(user, params[:name], params[:email], params[:message]).deliver
			flash[:success] = "Thank you for sharing Smileku, your message has been sent."
			redirect_to new_invite_path
		else
			flash[:error] = "Please make sure to fill in all the fields to send your message."
			render_new(user)
		end
	end

	private

	def render_new(user)
		@user = user
		render :new
	end
end