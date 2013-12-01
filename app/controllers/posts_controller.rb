class PostsController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def index
		@posts = Post.all
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