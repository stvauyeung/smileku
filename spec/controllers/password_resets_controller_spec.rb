require 'spec_helper'
require 'pry'

describe PasswordResetsController do	
	describe "POST create" do
		let(:bob) { Fabricate(:user, password: "password") }

		context "with valid token" do
			it "changes the user's password" do
				post :create, password: "newpassword", token: bob.token
				expect(bob.reload.authenticate("newpassword")).to eq(bob)
			end
			it "regenerates the user token" do
				oldtoken = bob.token
				post :create, password: "newpassword", token: bob.token
				expect(bob.reload.token).not_to eq(oldtoken)
			end
			it "sets flash success" do
				post :create, password: "newpassword", token: bob.token
				expect(flash[:success]).to be_present
			end
			it "redirects to login page" do
				post :create, password: "newpassword", token: bob.token
				response.should redirect_to login_path
			end
		end
		
		context "with valid token and invalid password" do
			it "doesn't reset password with invalid password" do
				post :create, password: "", token: bob.token
				expect(bob.reload.authenticate("password")).to eq(bob)			
			end
			it "redirects to show template" do
				post :create, password: "", token: bob.token
				expect(response).to redirect_to password_reset_path(bob.token)
			end
			it "sets flash error" do
				post :create, password: "", token: bob.token
				expect(flash[:error]).to be_present
			end
		end
		
		context "with invalid token" do
			it "redirects to expired token path" do
				post :create, password: "", token: "asdfwe"
				response.should redirect_to '/expired_reset'
			end
		end
	end
end