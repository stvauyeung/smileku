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
			it "sets session id to new user id" do
				post :create, :user => {username: "Joe", email: "joe@aol.com", password: "password"}
				expect(session[:user_id]).to eq(User.last.id)		
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

	describe 'GET edit' do
		context 'profile owned by current user' do
			let(:bob) { Fabricate(:user) }
			it 'assigns current user as @user' do
				sign_in_user(bob)
				get :edit, id: bob.id
				expect(assigns(:user)).to eq(bob)
			end
		end
		context 'profile not owned by current user' do
			let(:bob) { Fabricate(:user) }
			let(:tom) { Fabricate(:user) }
			it 'redirects to the user page' do
				sign_in_user(tom)
				get :edit, id: bob.id
				response.should redirect_to user_path(bob)
			end
			it 'displays flash error' do
				sign_in_user(tom)
				get :edit, id: bob.id
				expect(flash[:error]).to be_present
			end
		end
	end

	describe 'PUT update' do
		let(:bob) { Fabricate(:user) }
		let(:tom) { Fabricate(:user) }
		context 'profile owned by current user' do
			before { sign_in_user(bob) }
			it 'updates email with correct pw' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: bob.password }
				expect(bob.reload.email).to eq('bob@bob.com')
			end
			it 'does not update email with incorrect pw' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: 'abcd' }
				expect(bob.reload.email).to_not eq('bob@bob.com')
			end
			it 'renders the edit template if incorrect password' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: 'abcd' }
				response.should render_template :edit
			end
			it 'displays flash error if incorrect password' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: 'abcd' }
				expect(flash[:error]).to be_present
			end
		end
		context 'profile not owned by current user' do
			before { sign_in_user(tom) }
			it 'should not update user info' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: bob.password }
				expect(bob.reload.email).to_not eq('bob@bob.com')
			end
			it 'displays flash error' do
				put :update, id: bob.id, user: { email: 'bob@bob.com', password: bob.password }
				expect(flash[:error]).to be_present
			end
		end
	end
end