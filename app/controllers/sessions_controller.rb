class SessionsController < ApplicationController
  before_filter :require_logged_out, only: [:new]
  
  def new    
  end

  def create
    user = User.find(:first, :conditions => ["lower(username) = ?", params[:username].downcase])
    if user && user.authenticate(params[:password])
      session[:user_token] = user.token
      redirect_to home_path, :flash => {:success => "Welcome back #{user.username}!"}
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