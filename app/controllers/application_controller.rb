class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
  	unless session[:user_id].present?
  		flash[:error] = "You must be signed in to do that!"
  		redirect_to login_path
  	end
  end

  def current_user
  	User.find(session[:user_id])
  end
end
