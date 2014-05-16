class SessionsController < ApplicationController
  before_filter :require_logged_out, only: [:new]
  
  def new
    flash[:ref_url] = params[:ref_url]
  end

  def create
    user = User.find(:first, :conditions => ["lower(username) = ?", params[:username].downcase])
    ref_url = flash[:ref_url]
    if user && user.authenticate(params[:password])
      session[:user_token] = user.token
      handle_login_redirect(ref_url, user)
    else
      flash.now[:error] = "Sorry, username or password was incorrect, please try again."
      render :new
    end
  end

  def destroy
    session[:user_token] = nil
    redirect_to home_path
  end
end