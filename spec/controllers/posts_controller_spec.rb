require 'spec_helper'

describe PostsController do
	describe "GET new" do
		before { sign_in_admin }
		
		it_behaves_like "require_admin" do
			let(:action) { get :new }
		end
		
		it "creates a new post" do
			get :new
			assigns(:post).should be_new_record
		end
	end

	describe "POST create" do
		it_behaves_like "require_admin" do
			let(:action) { post :create }
		end

		context "successful post creation" do
			before do
				sign_in_admin
				post :create, post: Fabricate.attributes_for(:post, header: fixture_file_upload('/header.jpg', 'image/jpg'), mrec: fixture_file_upload('/mrec1.jpg', 'image/jpg'))
			end

			it "should create a new post" do
				expect(Post.count).to eq(1)
			end
			it "should redirect to the post path" do
				response.should redirect_to post_path(Post.last)
			end
		end

		context "unsuccessful post creation" do
			before do
				sign_in_admin
				post :create, post: Fabricate.attributes_for(:post, header: fixture_file_upload('/header.jpg', 'image/jpg'))
			end

			it "should not create a new post" do
				expect(Post.count).to eq(0)
			end
			it "should render the new post page" do
				response.should render_template :new
			end
		end
	end
end