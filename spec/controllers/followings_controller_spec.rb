require 'spec_helper'

describe FollowingsController do
	describe 'POST create' do
		let(:bob) { Fabricate(:user) }
		let(:sam) { Fabricate(:user) }

		it_behaves_like "require_login" do
			let(:action) { post :create, following: { followed_id: sam.id } }
		end
	end
end