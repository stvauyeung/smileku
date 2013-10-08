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
    if logged_in?
      @stories = Story.most_recent
    else
      redirect_to '/front'
    end
  end

  def show
    @story = Story.find(params[:id])
    @kus = @story.kus
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