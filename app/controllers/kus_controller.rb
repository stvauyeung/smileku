class KusController < ApplicationController
	def new
		@ku = Ku.new(story_id: params[:story_id], parent_id: params[:ku_id])
	end
end