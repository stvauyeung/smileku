require 'spec_helper'

describe InvitesController do
	describe "GET new" do
		let(:bob) { Fabricate(:user) }
		before { sign_in_user(bob) }

		it_behaves_like "require_login" do
			let(:action) { get :new }
		end

		it "sets current user as @user" do
			get :new
			expect(assigns[:user]).to eq(bob)
		end
	end

	describe "POST create" do
		let(:bob) { Fabricate(:user) }
		before { sign_in_user(bob) }

		it_behaves_like "require_login" do
			let(:action) { post :create }
		end

		context "with valid information" do
			it "sends an email to friend email" do
				post :create, :name => "Tim", :email => "tim@example.com", :message => "Message to Tim"
				expect(ActionMailer::Base.deliveries.last.to).to eq(["tim@example.com"])
			end
			it "redirects to invite page" do
				post :create, :name => "Tim", :email => "tim@example.com", :message => "Message to Tim"
				response.should redirect_to new_invite_path
			end
			it "displays flash success" do
				post :create, :name => "Tim", :email => "tim@example.com", :message => "Message to Tim"
				expect(flash[:success]).to be_present
			end
		end

		context "with invalid information" do
			it "does not send an email" do
				post :create, :name => "", :email => "tim@example.com", :message => "Message to Tim"
				expect(ActionMailer::Base.deliveries.count).to eq(0)
			end
			it "renders invite page" do
				post :create, :name => "Tim", :email => "", :message => "Message to Tim"
				response.should render_template :new
			end
			it "displays flash error" do
				post :create, :name => "Tim", :email => "tim@example.com", :message => ""
				expect(flash[:error]).to be_present
			end
		end
	end
end