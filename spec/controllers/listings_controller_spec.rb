require 'spec_helper'

describe ListingsController do
	let(:story) { Fabricate(:story) }
	let(:bob) { Fabricate(:user) }

	describe 'POST create' do
		before { sign_in_user(bob) }

		it_behaves_like 'require_login' do
			let(:action) { post :create, listing: { story_id: story.id } }
		end
		it 'creates a new listing' do
			post :create, listing: { story_id: story.id }
			expect(Listing.count).to eq(1)
		end
		it 'adds story to current user listings' do
			post :create, listing: { story_id: story.id }
			expect(bob.listings.count).to eq(1)
		end
	end

	describe 'DELETE destroy'
end