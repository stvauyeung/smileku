class UsersController < ApplicationController
  before_filter :require_logged_out, only: [:new, :create]
  before_filter(only: [:update, :edit]) { |c| c.require_user_match params[:id] }
  before_filter(except: [:new, :create]) { @user = User.find(params[:id]) }
  
  def new
    @user = User.new
    flash[:ref_url] = params[:ref_url]
  end

  def create
    @user = User.new(params[:user])
    ref_url = flash[:ref_url]
    if @user.save
      AppMailer.delay.welcome_email(@user)
      session[:user_token] = @user.token
      handle_login_redirect(ref_url, @user)
    else
      flash.now[:error] = "There was an issue creating your account, please see below."
      render :action => 'new'
    end
  end

  def show
    @kus = @user.kus.sort_by(&:created_at).reverse
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "You've successfully updated your profile!"
      redirect_to user_path(@user)
    else
      flash[:error] = "There was an error updating your email, please retry password or fix errors below."
      render :edit
    end    
  end
end