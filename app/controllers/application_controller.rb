class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :logged_in?, :current_user, :original_url, :handle_login_redirect

  def set_recent_posts(number)
    @recent_posts = Post.last(number).reverse
  end

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

  def require_admin
    if current_user.nil?
      flash[:error] = "You must be signed in to do that!"
      redirect_to login_path
    elsif current_user.admin == false
      flash[:error] = "You don't have permissions for that page!"
      redirect_to root_path
    end
  end

  def require_owner(content)
    unless content.user == current_user
      flash[:error] = "You must be the creator before you can edit!"
      redirect_to url_for(content)
    end
  end

  def require_user_match(slug)
    if current_user.to_param != slug
      flash[:error] = "You don't have permissions for that!"
      redirect_to user_path(User.find(slug))
    end
  end

  def current_user
  	@current_user ||= User.find_by_token(session[:user_token]) if session[:user_token]
  end

  def logged_in?
    !!current_user
  end

  def original_url
    request.original_url
  end

  def handle_login_redirect(ref_url, user)
    if ref_url.present?
      redirect_to ref_url, :flash => {:success => "Welcome to Smileku, #{user.username}!"}
    else
      redirect_to home_path, :flash => {:success => "Welcome to Smileku, #{user.username}!"}
    end
  end
end
