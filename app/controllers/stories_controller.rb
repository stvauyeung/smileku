class StoriesController < ApplicationController
  before_filter :require_login

  def new
    @story = Story.new
    @ku = Ku.new
  end

  def create
    @story = Story.new(params[:story])
    @story.user = User.first
    if @story.save
      redirect_to stories_path, flash: {success: "Your story was published."}
    else
      render :action => :new, flash: {error: "#{@story.errors.full_message.join(', ')}"}
    end
  end

  def index
    
  end
end