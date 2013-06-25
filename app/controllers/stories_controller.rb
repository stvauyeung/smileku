class StoriesController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    binding.pry
    @story = Story.new(params[:story])
    @story.user = User.first
    if @story.save
      redirect_to stories_path, flash: {success: "Your story was published."}
    else
      render :action => :new, flash: {error: "#{@story.errors.full_message.join(', ')}"}
    end
  end
end