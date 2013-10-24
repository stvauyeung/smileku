class ForgotPasswordsController < ApplicationController
	def new
	end

	def create
		@user = User.where(email: params[:email]).first
		if @user
			AppMailer.password_reset_email(@user).deliver
			flash[:success] = "Please check your email for instructions on resetting your password"
			redirect_to login_path
		else
			flash[:error] = params[:email].blank? ? "Email cannot be blank." : "Sorry, we have no record of anyone with that email address."
			redirect_to '/forgot_password'
		end
	end
end