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
		it "sets the ku parent" do
			get :new, story_id: story.id, parent_id: first_ku.id
			expect(assigns[:ku].parent_id).to eq(first_ku.id)
		end
	end

	describe "POST create" do
		context "successful creation" do
			it "creates a new ku" do

			end
			it "associates ku with parent"
			it "associates ku with story"
			it "redirects to ku page"
			it "sets flash success"
		end
		context "unsuccessful creation" do

		end
	end
end