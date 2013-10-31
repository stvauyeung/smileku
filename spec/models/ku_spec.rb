require 'spec_helper'
require 'pry'

describe Ku do
	# These first ones that just test the properites of the model seem to be overkill.
	# It seems like these tests will just mirror the model and only
	# catch unintentional deletes that should be caught during a code review.
	#
	# Have you read any articles advocating these tests?
	it { should belong_to(:story) }
	it { should belong_to(:user) }
	it { should have_many(:children).class_name('Ku') }
	it { should belong_to(:parent).class_name('Ku') }
	it { should validate_presence_of(:body) }
	it { should have_many(:votes) }
	it { should have_many(:comments) }

	# These tests look pretty through. You might want to create
	#  a helper method to perform the voting for each of these tests.
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
			expect(ku2.number_in_story).to eq(2)
		end
	end

	describe "#next_ku" do
		let(:story) { Fabricate(:story) }
		let(:one) { Fabricate(:ku, story_id: story.id) }
		let(:two) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:three) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:four) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }

		before do
			2.times{ Fabricate(:vote, voteable_id: two.id)}
			5.times{ Fabricate(:vote, voteable_id: four.id)}
			one.reload
			two.reload
			four.reload
		end

		it "returns the highest voted child of ku with children" do
			expect(one.next_ku).to eq(four)
		end
		it "returns nil if no children" do
			expect(four.next_ku).to be_nil
		end
	end

	describe "#prev_ku" do
		let(:story2) { Fabricate(:story) }
		let(:six) { Fabricate(:ku, story_id: story2.id) }
		let(:seven) { Fabricate(:ku, story_id: story2.id, parent_id: six.id) }
		let(:eight) { Fabricate(:ku, story_id: story2.id, parent_id: seven.id) }

		before do
			six.reload
			seven.reload
		end

		it "returns the parent of a ku" do
			expect(eight.prev_ku).to eq(seven)
		end
		it "returns nil if ku has no parent" do
			expect(six.prev_ku).to be_nil
		end
	end

	describe "#alt_ku" do
		let(:story) { Fabricate(:story) }
		let(:one) { Fabricate(:ku, story_id: story.id) }
		let(:two) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:three) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }
		let(:four) { Fabricate(:ku, story_id: story.id, parent_id: one.id) }

		before do
			2.times{ Fabricate(:vote, voteable_id: two.id)}
			5.times{ Fabricate(:vote, voteable_id: four.id)}
			one.reload
			two.reload
			four.reload
		end

		it "returns highest voted sibling of a ku" do
			expect(two.alt_ku).to eq(four)
		end

		it "returns nil if no siblings" do
			expect(one.alt_ku).to be_nil
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
