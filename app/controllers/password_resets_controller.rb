class PasswordResetsController < ApplicationController
	def show
		@token = params[:id]
	end

	def create
		
	end
end