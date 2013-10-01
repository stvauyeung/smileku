require 'spec_helper'

feature "signing in a user" do
	before { visit login_path }
	scenario "with existing user" do
		Fabricate(:user, username: 'bobbytron', password: 'password')
		login_user('bobbytron', 'password')
		page.should have_content "Welcome back bobbytron!"
	end
	scenario "with non existent user" do
		login_user('bobbytron', 'password')
		page.should have_content "Sorry, username or password was incorrect, please try again."
	end
end

feature "signing out a user" do
	before do
		Fabricate(:user, username: 'bobbytron', password: 'password')
		login_user('bobbytron', 'password')
	end
	scenario "it clears the session on logout" do
		click_link 'Logout'
		page.should have_content "You've successfully signed out."
	end
end