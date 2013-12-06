require 'spec_helper'

feature "user updates profile" do
	before do
		Fabricate(:user, username: 'bob', password: 'password')
		login_user('bob', 'password')
	end

	scenario "user updates email address with right password" do
		click_link 'Profile'
		page.should have_content "bob's Bio"
		
		click_link 'Edit Profile'
		fill_in 'Update your email', with: 'bobby.b@yahoo.com'
		click_button 'Update'
		page.should have_content "You've successfully updated your profile!"
	end

	scenario "user updates email without right password" do
		click_link 'Profile'
		page.should have_content "bob's Bio"
		
		click_link 'Edit Profile'
		fill_in 'Update your email', with: ''
		click_button 'Update'
		page.should have_content "There was an error updating your email, please retry password or fix errors below."
	end
end