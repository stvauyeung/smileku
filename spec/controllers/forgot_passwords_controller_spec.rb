require 'spec_helper'

describe ForgotPasswordsController do
	describe "POST create" do
		context "with blank email" do
			it "redirects to forgot password page" do
				post :create, email: ""
				expect(response).to redirect_to '/forgot_password'
			end
			it "displays flash error" do
				post :create, email: ""
				expect(flash[:error]).to be_present
			end
		end
		context "with valid email" do
			let(:bob) { Fabricate(:user) }
			it "sends password reset email to user" do
				post :create, email: bob.email
				expect(ActionMailer::Base.deliveries.last.to).to eq([bob.email])
			end
			it "redirects to login path" do
				post :create, email: bob.email
				expect(response).to redirect_to login_path
			end
			it "sets flash success" do
				post :create, email: bob.email
				expect(flash[:success]).to be_present
			end
		end
		context "with invalid email" do
			it "redirects to forgot password page" do
				post :create, email: "fake@aol.com"
				expect(response).to redirect_to '/forgot_password'
			end
			it "sets flash error" do
				post :create, email: "fake@aol.com"
				expect(flash[:error]).to be_present
			end
		end
	end
end