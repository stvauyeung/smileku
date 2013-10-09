require 'spec_helper'
require 'pry'

describe Ku do
	it { should belong_to(:story) }
	it { should belong_to(:user) }
	it { should have_many(:children).class_name('Ku') }
	it { should belong_to(:parent).class_name('Ku') }
	it { should validate_presence_of(:body) }
	it { should have_many(:votes) }
	it { should have_many(:comments) }

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

	describe "#next_ku" do
		let(:story) { Fabricate(:story) }
		let(:one) { Fabricate(:ku, story_id: story.id) }
		let(:two) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:three) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:four) { Fabricate(:ku, story_id: story.id, parent_id: two.id) }
		let(:five) { Fabricate(:ku, story_id: story.id, parent_id: two.id) }
		
		let(:story2) { Fabricate(:story) }
		let(:six) { Fabricate(:ku, story_id: story2.id) }
		let(:seven) { Fabricate(:ku, story_id: story2.id, parent_id: six.id) }
		let(:eight) { Fabricate(:ku, story_id: story2.id, parent_id: six.id) }
		let(:nine) { Fabricate(:ku, story_id: story2.id, parent_id: seven.id) }

		before do
			story.reload
			one.reload
			two.reload
			six.reload
			seven.reload
			eight.reload
		end

		it "returns the first child of a ku with children" do
			expect(one.next_ku).to eq(two)
		end
		it "returns sibling of ku with no children" do
			expect(three.next_ku).to eq(two)
		end
		it "returns sibling of parent of ku with no children or siblings" do
			expect(nine.next_ku).to eq(eight)
		end
		it "returns nil if no children or siblings or parent siblings" do
			story = Fabricate(:story)
			ku = Fabricate(:ku, story_id: story.id)
			expect(ku.next_ku).to be_nil
		end
	end

	describe "#skip_ku" do
		let(:story2) { Fabricate(:story) }
		let(:six) { Fabricate(:ku, story_id: story2.id) }
		let(:seven) { Fabricate(:ku, story_id: story2.id, parent_id: six.id) }
		let(:eight) { Fabricate(:ku, story_id: story2.id, parent_id: six.id) }
		let(:nine) { Fabricate(:ku, story_id: story2.id, parent_id: seven.id) }

		before do
			story2.reload
			six.reload
			seven.reload
		end
		it "returns a ku from a different branch" do
			expect(eight.skip_ku).to eq(seven)
		end
	end

	describe "#vote_count" do
		let(:ku) { Fabricate(:ku) }
		before do
			3.times { Fabricate(:vote, voteable_id: ku.id) }
			2.times { Fabricate(:vote, voteable_id: ku.id, value: false) }
		end
		it "returns the number of votes true minus false" do
			expect(ku.vote_count).to eq(1)
		end
	end
end