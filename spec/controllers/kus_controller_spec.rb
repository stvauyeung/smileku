require 'spec_helper'

describe KusController do
	describe "GET new" do
		let(:story) { Fabricate(:story) }
		let(:first_ku) { Fabricate(:ku, story_id: story.id) }
		before { sign_in_user }

		it_behaves_like "require_login" do
			let(:action) { get :new, story_id: story.id, parent_id: first_ku.id }
		end
		it "creates a new ku" do
			get :new, story_id: story.id, parent_id: first_ku.id
			expect(assigns[:ku]).to be_an_instance_of(Ku)
		end
		it "sets ku story as story id" do
			get :new, story_id: story.id, parent_id: first_ku.id
			expect(assigns[:ku].story_id).to eq(story.id)
		end
	end

	describe "POST create" do
		let(:bob) { Fabricate(:user) }
		let(:story) { Fabricate(:story) }
		let(:first_ku) { Fabricate(:ku, story_id: story.id) }
		before { sign_in_user(bob) }

		it_behaves_like "require_login" do
			let(:action) { post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id }
		end
		context "successful creation" do
			it "redirects to new ku show page" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				response.should redirect_to ku_path(Ku.find(2))
			end
			it "creates a new ku" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(Ku.count).to eq(2)
			end
			it "sets current user as ku user" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(Ku.last.user).to eq(bob)
			end
			it "associates ku with parent" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(Ku.last.parent_id).to eq(first_ku.id)
			end
			it "associates ku with story" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(Ku.last.story_id).to eq (story.id)
			end
			it "sets flash success" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(flash[:success]).to be_present
			end
		end
		context "unsuccessful creation" do
			it "should not create a new ku" do
				post :create, ku: {parent_id: first_ku.id, body: ""}, story_id: story.id
				expect(Ku.count).to eq(1)
			end
			it "should render the new ku page" do
				post :create, ku: {parent_id: first_ku.id, body: ""}, story_id: story.id
				response.should render_template :new
			end
			it "should display flash error" do
				post :create, ku: {parent_id: first_ku.id, body: ""}, story_id: story.id
				expect(flash[:error]).to be_present
			end
		end
	end
	describe "GET edit" do
		let(:bob) { Fabricate(:user) }
		let(:sam) { Fabricate(:user) }
		let(:story) { Fabricate(:story) }
		let(:ku) { Fabricate(:ku, story_id: story.id, user_id: bob.id)}

		context "ku belongs to signed in user" do
			before { sign_in_user(bob) }
			it "sets ku as id" do
				get :edit, id: ku.id
				expect(assigns[:ku]).to eq(ku)
			end
			it "sets story as kus story" do
				get :edit, id: ku.id
				expect(assigns[:story]).to eq(story)
			end
		end

		context "ku doesn't belong to signed in user" do
			before { sign_in_user(sam) }
			it "redirects to show ku page" do
				get :edit, id: ku.id
				response.should redirect_to ku_path(ku)
			end
			it "sets flash error" do
				get :edit, id: ku.id
				expect(flash[:error]).to be_present
			end
		end
	end
	describe "POST update" do
		let(:bob) { Fabricate(:user) }
		let(:story) { Fabricate(:story) }
		let(:ku) { Fabricate(:ku, story_id: story.id, user_id: bob.id)}
		before { sign_in_user(bob) }
		
		context "successful update" do
			it "redirects to ku page" do
				put :update, id: ku.id, ku: { body: "test test" }
				response.should redirect_to ku_path(ku)
			end
			it "changes the ku body" do
				put :update, id: ku.id, ku: { body: "test test" }
				expect(ku.reload.body).to eq("test test")
			end
			it "flashes success message" do
				put :update, id: ku.id, ku: { body: "test test" }
				expect(flash[:success]).to be_present
			end
		end

		context "unsuccessful update" do
			it "does not update the ku" do
				put :update, id: ku.id, ku: { body: "" }
				expect(ku.reload.body).to_not eq("")
			end
			it "renders the edit template" do
				put :update, id: ku.id, ku: { body: "" }
				response.should render_template :edit
			end
			it "flashes error message" do
				put :update, id: ku.id, ku: { body: "" }
				expect(flash[:error]).to be_present
			end
		end
	end
end