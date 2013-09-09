require 'spec_helper'

describe Story do
	it { should belong_to(:user) }
	it { should have_many(:kus) }
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:large_cover_url) }

	describe "#most_recent" do
		before do
			8.times { Fabricate(:story) }
		end
		let(:subject) { Story.most_recent }
		it "returns the last six stories by desc" do
			subject.should eq(Story.last(6).reverse)
		end
	end
end