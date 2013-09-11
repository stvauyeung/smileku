class StoriesController < ApplicationController
  before_filter :require_login, except: [:index, :show]

  def new
    @story = Story.new
    @ku = Ku.new
  end

  def create
    @story = Story.new(params[:story])
    @ku = Ku.new(params[:ku])
    if @story.valid? && @ku.valid?
      handle_new_story(@story, @ku)
      redirect_to story_path(@story), flash: {success: "Your story was published."}
    else
      flash[:error] = "Whoops! #{@story.errors.full_messages.join(', ')} #{@ku.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def index
    @stories = Story.most_recent
  end

  def show
    @story = Story.find(params[:id])
    @ku = @story.kus.first
  end

  private

  def handle_new_story(story, ku)
    story.save
    ku.save
    story.update_column(:user_id, current_user.id)
    ku.update_column(:user_id, current_user.id)
    story.kus << @ku
  end
end