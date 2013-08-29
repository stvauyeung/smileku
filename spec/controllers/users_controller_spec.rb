require 'spec_helper'

describe UsersController do
	describe 'GET new' do
		it "creates a new user" do
			get :new
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe 'POST create' do
		context "valid user attributes" do
			it "creates a new user" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: "password"}
				expect(User.count).to eq(1)
			end
			it "redirects to home page" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: "password"}
				expect(response).to redirect_to stories_path
			end
			it "displays flash message" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: "password"}
				expect(flash[:success]).to be_present
			end
		end
		context "invalid user attributes" do
			it "does not create new user" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: ""}
				expect(User.count).to eq(0)
			end
			it "renders the new template" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: ""}
				expect(response).to render_template :new
			end
			it "displays flash error" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: ""}
				expect(flash[:error]).to be_present
			end
		end
	end
end