class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to '/', :flash => {:success => "You successfully created an account.  Welcome!"}
    else
      flash.now[:error] = "Please fix the following errors: #{@user.errors.full_messages}"
      render :action => 'new'
    end
  end
end