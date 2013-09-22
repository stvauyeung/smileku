class StaticsController < ApplicationController
	before_filter :require_logged_out, only: [:front]
	
	def front
		@user = User.new
	end
end