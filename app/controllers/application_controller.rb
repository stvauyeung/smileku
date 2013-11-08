class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?, :current_user

  def require_logged_out
    if logged_in?
      redirect_to stories_path
    end
  end

  def require_login
  	unless logged_in?
  		flash[:error] = "You must be signed in to do that!"
  		redirect_to login_path
  	end
  end

  def require_owner(content)
    unless content.user == current_user
      flash[:error] = "You must be the creator before you can edit!"
      redirect_to url_for(content)
    end
  end

  def require_user_match(params_id)
    if current_user.id != params_id.to_i
      flash[:error] = "You don't have permissions for that!"
      redirect_to user_path(User.find(params_id))
    end
  end

  def current_user
  	@current_user ||= User.find_by_token(session[:user_token]) if session[:user_token]
  end

  def logged_in?
    !!current_user
  end
end
