class StoriesController < ApplicationController
  before_filter :require_login

  def new
    @story = Story.new
    @ku = Ku.new
  end

  def create
    @story = Story.new(params[:story])
    @ku = Ku.new(params[:ku])
    if @story.save && @ku.save
      @story.update_column(:user_id, current_user.id)
      @ku.update_column(:user_id, current_user.id)
      @story.kus << @ku
      redirect_to story_path(@story), flash: {success: "Your story was published."}
    else
      render :action => :new, flash: {error: "#{@story.errors.full_message.join(', ')}"}
    end
  end

  def index
    
  end
end