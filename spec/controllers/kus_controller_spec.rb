require 'spec_helper'

describe KusController do
	describe "GET new" do
		let(:story) { Fabricate(:story) }
		let(:first_ku) { Fabricate(:ku, story_id: story.id) }

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
		context "successful creation" do
			let(:story) { Fabricate(:story) }
			let(:first_ku) { Fabricate(:ku, story_id: story.id) }
			
			it "redirects to new ku show page" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				response.should redirect_to story_ku_path(story, Ku.find(2))
			end
			it "creates a new ku" do
				post :create, ku: {parent_id: first_ku.id, body: "body"}, story_id: story.id
				expect(Ku.count).to eq(2)
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

		end
	end
end