class StaticsController < ApplicationController
	layout 'front'
	before_filter :require_logged_out, only: [:front]
	
	def front
		@user = User.new
	end
end