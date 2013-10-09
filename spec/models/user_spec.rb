require 'spec_helper'

describe User do
	it { should have_many(:stories) }
	it { should have_many(:kus) }
	it { should have_many(:votes) }
	it { should have_many(:comments) }
	it { should have_secure_password }
	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:username) }
	it { should validate_uniqueness_of(:email) }

	describe '#owns' do
		let(:sam) { Fabricate(:user) }
		let(:bob) { Fabricate(:user) }
		let(:story) { Fabricate(:story) }
		let(:sams_ku) { Fabricate(:ku, story_id: story.id, user_id: sam.id) }
		it 'returns true if object user_id matches' do
			expect(sam.owns(sams_ku)).to be_true
		end
		it 'returns false if object user_id does not match' do
			expect(bob.owns(sams_ku)).to be_false
		end
	end
end