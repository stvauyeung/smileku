class PostsController < ApplicationController
	before_filter :require_admin, except: [:index, :show]

	def index
		
	end

	def new
		@post = Post.new
	end

	def create
		
	end

	def show
		
	end
end