class StoriesController < ApplicationController
  before_filter :require_login, except: [:index, :show]
  before_filter(only: [:index]) { |c| c.set_recent_posts(2) }

  def new
    @story = Story.new
    @ku = Ku.new
  end

  def create
    @story = Story.new(params[:story].merge!(user_id: current_user.id))
    @ku = Ku.new(body: params[:ku][:body])
    if @story.valid? && params[:ku][:body].length > 0
      @story.save
      @ku = Ku.create(params[:ku].merge!(story_id: @story.id, user_id: current_user.id))
      redirect_to story_path(@story)
    else
      flash[:error] = "Whoops! There was a problem saving your story. #{@story.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def index
    if logged_in?
      @stories = Story.most_recent(10)
      @kus = Ku.most_recent
    else
      redirect_to '/front'
    end
  end

  def show
    @story = Story.find(params[:id])
    @description = @story.filter(:description)
    @kus = @story.kus.order("created_at ASC")
  end
end