require 'spec_helper'

feature "new user registration" do
	before { visit registration_path }

	scenario "valid user information" do
		fill_in 'Username', with: 'mario'
		fill_in 'Email', with: 'm@nintendo.com'
		fill_in 'Password', with: 'password'
		fill_in 'Password confirmation', with: 'password'
		click_button 'Create Account'
		page.should have_content 'You successfully created an account.  Welcome!'
	end

	scenario "with invalid information" do
		fill_in 'Username', with: 'mario'
		fill_in 'Password', with: 'password'
		fill_in 'Password confirmation', with: 'password'
		click_button 'Create Account'
		page.should have_content 'There was an issue creating your account, please see below.'
	end

	scenario "with an existing username" do
		Fabricate(:user, username: 'mario')
		fill_in 'Username', with: 'mario'
		fill_in 'Password', with: 'password'
		fill_in 'Password confirmation', with: 'password'
		click_button 'Create Account'
		page.should have_content 'has already been taken'
	end
end