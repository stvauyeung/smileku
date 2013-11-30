class PostsController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def index
		
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[:post])
		if @post.save
			flash[:success] = "Post created!"
			redirect_to post_path(@post)
		else
			flash[:error] = "There were errors with your post!"
			render :new
		end
	end

	def show
		
	end
end