require 'spec_helper'

describe Story do
	it { should belong_to(:user) }
	it { should have_many(:kus) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:large_cover) }

	describe "#most_recent" do
		before do
			8.times { Fabricate(:story) }
		end
		let(:subject) { Story.most_recent }
		it "returns the last six stories by desc" do
			subject.should eq(Story.last(10).reverse)
		end
	end

	describe "#truncated_title" do
		it "shortens a story title to 25 characters" do
			story = Fabricate(:story)
			expect(story.truncated_title.size).to eq(25)
		end
	end
end