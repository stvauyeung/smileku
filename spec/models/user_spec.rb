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

	it "has token on create" do
		bob = Fabricate(:user)
		bob.token.should be_present
	end

	it "sets default value for location" do
		bob = Fabricate(:user)
		bob.location.should eq("Planet Earth")
	end
	
	it "sets default value for bio" do
		bob = Fabricate(:user)
		bob.bio.should be_present
	end

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

	describe "#is_follower" do
		let(:sam) { Fabricate(:user) }
		let(:f1) { Fabricate(:following, follower_id: sam.id) }
		let(:f2) { Fabricate(:following, follower_id: sam.id) }
		let(:f3) { Fabricate(:following) }
		it 'returns followings where user_id is follower_id' do
			expect(sam.is_follower).to eq([f1, f2])
		end
	end

	describe "#is_followed" do
		let(:sam) { Fabricate(:user) }
		let(:f1) { Fabricate(:following, followed_id: sam.id) }
		let(:f2) { Fabricate(:following, followed_id: sam.id) }
		let(:f3) { Fabricate(:following) }
		it 'returns followings where user_id is followed_id' do
			expect(sam.is_followed).to eq([f1, f2])
		end
	end

	describe "#following?" do
		let(:sam) { Fabricate(:user) }
		let(:bob) { Fabricate(:user) }
		before { Fabricate(:following, follower_id: sam.id, followed_id: bob.id) }
		it 'returns true if user is following given user' do
			expect(sam.following?(bob)).to be_true
		end
		it 'returns false if user not following given user' do
			expect(bob.following?(sam)).to be_false
		end
	end

	describe "#followers" do
		let(:sam) { Fabricate(:user) }
		let(:bob) { Fabricate(:user) }
		let(:joe) { Fabricate(:user) }
		before do 
			Fabricate(:following, follower_id: sam.id, followed_id: bob.id)
			Fabricate(:following, follower_id: joe.id, followed_id: bob.id)
		end

		it 'returns an array of users following subject' do
			expect(bob.followers).to eq([sam, joe])
		end
	end

	describe "#following" do
		let(:sam) { Fabricate(:user) }
		let(:bob) { Fabricate(:user) }
		let(:joe) { Fabricate(:user) }
		before do 
			Fabricate(:following, follower_id: bob.id, followed_id: sam.id)
			Fabricate(:following, follower_id: bob.id, followed_id: joe.id)
		end

		it 'returns an array of users followed by subject' do
			expect(bob.following).to eq([sam, joe])
		end
	end
end