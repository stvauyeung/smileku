require 'spec_helper'

describe Ku do
	it { should belong_to(:story) }
	it { should belong_to(:user) }
	it { should have_many(:children).class_name('Ku') }
	it { should belong_to(:parent).class_name('Ku') }
	it { should validate_presence_of(:body) }

	describe "#author_name" do
		it "returns the username of ku user" do
			bob = Fabricate(:user, username: "bobby")
			ku = Fabricate(:ku, user_id: bob.id)
			expect(ku.author_name).to eq("bobby")
		end
	end

	describe "#number_in_story" do
		it "returns ku's number in a story for views" do
			story = Fabricate(:story)
			ku1 = Fabricate(:ku, story_id: story.id)
			ku2 = Fabricate(:ku, story_id: story.id)
			expect(ku2.number_in_story).to eq("KU#2")
		end
	end
end