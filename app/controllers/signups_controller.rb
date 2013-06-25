class SignupsController < ApplicationController
  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(params[:signup])
    if @signup.save
      redirect_to '/', :flash => {:success => "You successfully created an account.  Welcome!"}
    else
      flash.now[:error] = "Please fix the following errors: #{@signup.errors.full_messages}"
      render :action => 'new'
    end
  end
end