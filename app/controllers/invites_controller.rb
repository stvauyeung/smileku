class InvitesController < ApplicationController
	before_filter :require_login

	def new
		@user = current_user
	end

	def create
		user = current_user
		if params[:name].present? && params[:email].present? && params[:message].present?
			AppMailer.invite_email(user, params[:name], params[:email], params[:message]).deliver
			flash[:success] = "Thank you for sharing Smileku, your message has been sent."
			redirect_to new_invite_path
		else
			flash[:error] = "Please make sure to fill in all the fields to send your message."
			render :new
		end
	end
end