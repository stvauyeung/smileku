class PasswordResetsController < ApplicationController
	def show
		@token = params[:id]
	end

	def create
		user = User.find_by_token(params[:token])
		if user && params[:password].present?
			user.password = params[:password]
			user.generate_token
			user.save!
			flash[:success] = "You've successfully reset your password. Use your new password to login now."
			redirect_to login_path
		else
			render :show
		end
		
	end
end