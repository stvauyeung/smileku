class StaticsController < ApplicationController
	before_filter(only: [:home]) { |c| c.set_recent_posts(2) }
	layout :resolve_layout

	def front
		@user = User.new
		@stories = Story.find_longest(5)
		@posts = Post.most_recent(4)
	end

	def home
    if logged_in?
      @recent_stories = Story.most_recent(4)
      @top_stories = Story.find_longest(10)
      @activities = Activity.most_recent(10)
    else
      redirect_to '/front'
    end
	end

	def contact
		
	end

	private

	def resolve_layout
		case action_name
		when "front"
			"front"
		else
			"application"
		end
	end
end