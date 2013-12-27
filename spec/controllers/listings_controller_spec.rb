require 'spec_helper'
require 'pry'

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

	describe 'DELETE destroy' do
		let(:story) { Fabricate(:story) }
		let(:bob) { Fabricate(:user) }
		let(:joe) { Fabricate(:user) }
		let(:listing) { Fabricate(:listing, user_id: bob.id) }

		it_behaves_like 'require_login' do
			let(:action) { delete :destroy, id: listing.id }
		end

		it 'deletes listing if current user is listing user' do
			sign_in_user(bob)
			delete :destroy, id: listing.id
			expect(bob.reload.listings.count).to eq(0)
		end
		it 'does not delete listing if current user not listing user' do
			sign_in_user(joe)
			delete :destroy, id: listing.id
			expect(bob.reload.listings.count).to eq(1)
		end
	end
end