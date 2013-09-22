class SessionsController < ApplicationController
  before_filter :require_logged_out, only: [:new]
  
  def new    
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to stories_path, :flash => {:success => "Welcome back #{user.username}!"}
    else
      flash.now[:error] = "Sorry, username or password was incorrect, please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :flash => { success: "You've successfully signed out." }
  end
end