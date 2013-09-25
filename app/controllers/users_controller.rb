class UsersController < ApplicationController
  before_filter :require_logged_out, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to stories_path, :flash => {:success => "You successfully created an account.  Welcome!"}
    else
      flash.now[:error] = "There was an issue creating your account, please see below."
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end
end