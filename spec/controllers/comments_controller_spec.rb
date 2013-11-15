require 'spec_helper'

describe CommentsController do
	describe "POST create" do
		let(:story) { Fabricate(:story) }
		let(:bob) { Fabricate(:user) }
		let(:ku) { Fabricate(:ku, story_id: story.id, user_id: bob.id) }
		before { sign_in_user(bob) }

		it_behaves_like "require_login" do
			let(:action) { post :create, ku_id: ku.id }
		end
		
		context "valid comment" do
			it "creates a new comment" do
				post :create, comment: { body: "booga" }, ku_id: ku.id
				expect(Comment.count).to eq(1)
			end
			it "sets comment belonging to ku" do
				post :create, comment: { body: "booga" }, ku_id: ku.id
				expect(Comment.first.ku).to eq(ku)
			end
			it "sets comment belonging to user" do
				post :create, comment: { body: "booga" }, ku_id: ku.id
				expect(Comment.first.user).to eq(bob)
			end
		end

		context "invalid comment" do
			it "doesn't create a comment" do
				post :create, comment: { body: "" }, ku_id: ku.id
				expect(Comment.count).to eq(0)
			end
			it "renders the ku show page" do
				post :create, comment: { body: "" }, ku_id: ku.id
				expect(response).to redirect_to ku_path(ku)
			end
			it "displays flash error" do
				post :create, comment: { body: "" }, ku_id: ku.id
				expect(flash[:error]).to be_present
			end
		end
	end
end