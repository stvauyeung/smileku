class StaticsController < ApplicationController
	layout 'front'

	def front
		@user = User.new
	end
end