class PasswordResetsController < ApplicationController
	def show
		@token = params[:id]
	end

	def create
		user = User.find_by_token(params[:token])
		if user 
			if params[:password].present?
				user.password = params[:password]
				user.generate_token
				user.save!
				flash[:success] = "You've successfully reset your password. Use your new password to login now."
				redirect_to login_path
			else
				flash[:error] = "Sorry, you must enter a valid password"
				redirect_to password_reset_path(params[:token])
			end
		else
			redirect_to '/expired_reset'
		end
	end

	def expired
	end
end