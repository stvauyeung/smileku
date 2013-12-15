require 'spec_helper'
require 'pry'

describe FollowingsController do
	let(:bob) { Fabricate(:user) }
	let(:sam) { Fabricate(:user) }
	let(:joe) { Fabricate(:user) }

	describe 'POST create' do
		before { sign_in_user(bob) }

		it_behaves_like 'require_login' do
			let(:action) { post :create, following: { followed_id: sam.id } }
		end

		it 'creates following if no following bt users exists' do
			post :create, following: { followed_id: sam.id }
			expect(bob.followings.count).to eq(1)
		end
		it 'does not create following if following bt users exists' do
			Fabricate(:following, follower_id: bob.id, followed_id: sam.id)
			post :create, following: { followed_id: sam.id }
			expect(bob.followings.count).to eq(1)
		end
		it 'it does not allower user to follow herself' do
			post :create, following: { followed_id: bob.id }
			expect(bob.followings.count).to eq(0)
		end
	end

	describe 'DELETE destroy' do
		let(:following) { Fabricate(:following, follower_id: bob.id, followed_id: sam.id) }
		before { sign_in_user(bob) }

		it_behaves_like 'require_login' do
			let(:action) { delete :destroy, id: following.id }
		end

		it 'deletes following if current user is follower' do
			delete :destroy, id: following.id
			expect(bob.followings.count).to eq(0)
		end

		it 'does not delete following if current user not follower' do
			sign_in_user(joe)
			delete :destroy, id: following.id
			expect(bob.followings.count).to eq(1)
		end
	end
end