class PostsController < ApplicationController
	before_filter :require_admin, except: [:index, :show]
	before_filter(only: [:show]) { |c| c.set_recent_posts(3) }

	def index
		@posts = Post.all.reverse
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[:post])
		if @post.save
			flash[:success] = "Post created!"
			redirect_to url_for @post
		else
			flash[:error] = "There were errors with your post!"
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			flash[:success] = "Post updated!"
			redirect_to @post
		else
			flash[:error] = "Unsuccessful update..."
			render :edit
		end
	end

	def show
		@post = Post.find(params[:id])
	end
end