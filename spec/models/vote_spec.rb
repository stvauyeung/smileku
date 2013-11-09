require 'spec_helper'

describe Vote do
	it { should belong_to(:voteable) }
	it { should belong_to(:user) }

	describe ".for_ku" do
		let(:bob) { Fabricate(:user) }
		let(:ku) { Fabricate(:ku) }

		it "creates new vote if ku has no votes from user" do
			Vote.for_ku(ku, bob, 'true')
			expect(Vote.count).to eq(1)
		end
		it "removes vote if ku has vote from user of same value" do
			Fabricate(:vote, user_id: bob.id)
			Vote.for_ku(ku, bob, 'true')
			expect(Vote.count).to eq(0)
		end
		it "replaces vote if ku has vote from user of opposite value" do
			Fabricate(:vote, user_id: bob.id)
			Vote.for_ku(ku, bob, 'false')
			expect(Vote.last.value).to eq(false)
		end
	end
end