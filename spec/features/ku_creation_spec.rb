require 'spec_helper'

feature "user adds a ku" do
	before do 
		Fabricate(:user, username: 'bobby', password: 'password')
		Fabricate(:story, user_id: User.first.id)
		Fabricate(:ku, story_id: Story.first.id, user_id: User.first.id)
		login_user('bobby', 'password')
	end

	scenario "user ads valid ku" do
		visit ku_path(Ku.first)
		click_link 'Add a Ku'
		fill_in 'ku_body', with: "Adding to the story"
		click_button 'Publish'
		page.should have_content "Adding to the story"
	end

	scenario "user ads invalid ku" do
		visit ku_path(Ku.first)
		click_link 'Add a Ku'
		fill_in 'ku_body', with: ""
		click_button 'Publish'
		page.should have_content "You should write something!"
	end
end