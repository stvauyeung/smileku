class UsersController < ApplicationController
  before_filter :require_logged_out, only: [:new, :create]
  before_filter(only: [:update, :edit]) { |c| c.require_user_match params[:id] }
  
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:password])
      @user.update_attributes(params[:user])
      flash[:success] = "You've successfully updated your profile!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Your password was incorrect, please enter your password to edit."
      render :edit
    end    
  end
end