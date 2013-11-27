require 'spec_helper'

describe PostsController do
	describe "GET new" do
		let(:bob) { Fabricate(:admin) }
		before { sign_in_user(bob) }
		
		it_behaves_like "require_admin" do
			let(:action) { get :new }
		end
		
		it "creates a new post" do
			post :create, post: Fabricate.attributes_for(:post, mrec: fixture_file_upload('/mrec1.jpg', 'image/jpg'), header: fixture_file_upload('/the-harvest-writer.jpg', 'image/jpg'))
			expect(Post.count).to eq(1)
		end
	end
end