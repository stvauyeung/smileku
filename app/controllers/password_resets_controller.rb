class PasswordResetsController < ApplicationController
	def show
		@token = params[:id]
	end

	def create
		user = User.find_by_token(params[:token])
		if user 
			if params[:password].present?
				update_password(user, params[:password])
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

	private

	# This should be in the User model.
	def update_password(user, password)
		user.password = password
		user.generate_token
		user.save!
	end
end
