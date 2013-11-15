require 'spec_helper'

describe SessionsController do
	describe "POST create" do
		context "with valid user" do
			let(:bob) { Fabricate(:user) }
			it "redirects to stories page" do
				post :create, username: bob.username, password: bob.password
				response.should redirect_to stories_path
			end
			it "sets session to user id" do
				post :create, username: bob.username, password: bob.password
				expect(session[:user_token]).to eq(bob.token)
			end
			it "displays flash success" do
				post :create, username: bob.username, password: bob.password
				expect(flash[:success]).to be_present
			end
		end

		context "with invalid user" do
			it "renders the login page" do
				post :create, username: "", password: "password"
				response.should render_template :new
			end
			it "displays flash error" do
				post :create, username: "", password: "password"
				expect(flash[:error]).to be_present
			end
		end
	end

	describe "POST destroy" do
		let(:bob) { Fabricate(:user) }
		before { session[:user_token] = bob.token }
		
		it "sets session to nil" do
			post :destroy
			expect(session[:user_token]).to be_nil
		end
		it "redirects to root path" do
			post :destroy
			response.should redirect_to root_path
		end
	end
end