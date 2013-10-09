require 'spec_helper'

describe CommentsController do
	describe "POST create" do
		it_behaves_like "require_login" 
		it "creates a new comment"
		it "sets comment belonging to ku"
		it "sets comment belonging to user"
	end
end